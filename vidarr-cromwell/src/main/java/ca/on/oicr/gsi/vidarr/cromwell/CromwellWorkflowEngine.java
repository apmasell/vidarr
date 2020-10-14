package ca.on.oicr.gsi.vidarr.cromwell;

import ca.on.oicr.gsi.status.SectionRenderer;
import ca.on.oicr.gsi.vidarr.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import io.prometheus.client.Counter;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Collections;
import java.util.Optional;
import java.util.concurrent.TimeUnit;
import javax.xml.stream.XMLStreamException;

/** Run workflows using Cromwell */
public final class CromwellWorkflowEngine
    extends BaseJsonWorkflowEngine<EngineState, String, Void> {
  public static WorkflowEngineProvider provider() {
    return new WorkflowEngineProvider() {
      @Override
      public WorkflowEngine readConfiguration(ObjectNode node) {
        return new CromwellWorkflowEngine(node.get("url").asText());
      }

      @Override
      public String type() {
        return "cromwell";
      }
    };
  }

  static WorkMonitor.Status statusFromCromwell(String status) {
    return switch (status) {
      case "On Hold" -> WorkMonitor.Status.WAITING;
      case "Submitted" -> WorkMonitor.Status.QUEUED;
      case "Running" -> WorkMonitor.Status.RUNNING;
      default -> WorkMonitor.Status.UNKNOWN;
    };
  }

  private static final int CHECK_DELAY = 10;
  static final HttpClient CLIENT =
      HttpClient.newBuilder()
          .version(HttpClient.Version.HTTP_1_1)
          .followRedirects(HttpClient.Redirect.NORMAL)
          .connectTimeout(Duration.ofSeconds(20))
          .build();
  static final Counter CROMWELL_FAILURES =
      Counter.build(
              "vidarr_cromwell_failed_requests",
              "The number of failed HTTP requests to the Cromwell server")
          .labelNames("target")
          .register();
  static final Counter CROMWELL_REQUESTS =
      Counter.build(
              "vidarr_cromwell_total_requests",
              "The number of HTTP requests to the Cromwell server")
          .labelNames("target")
          .register();
  static final ObjectMapper MAPPER = new ObjectMapper();
  private final String baseUrl;

  protected CromwellWorkflowEngine(String baseUrl) {
    super(MAPPER, EngineState.class, String.class, Void.class);
    this.baseUrl = baseUrl;
  }

  private void check(EngineState state, WorkMonitor<Result<String>, EngineState> monitor) {
    try {
      monitor.log(
          System.Logger.Level.INFO,
          String.format("Checking Cromwell workflow %s on %s", state.getCromwellId(), baseUrl));
      CROMWELL_REQUESTS.labels(baseUrl).inc();
      CLIENT
          .sendAsync(
              HttpRequest.newBuilder()
                  .uri(
                      URI.create(
                          String.format(
                              "%s/api/workflows/v1/%s/status", baseUrl, state.getCromwellId())))
                  .timeout(Duration.ofMinutes(1))
                  .GET()
                  .build(),
              new JsonBodyHandler<>(MAPPER, WorkflowStatusResponse.class))
          .thenApply(HttpResponse::body)
          .thenAccept(
              s -> {
                final var result = s.get();
                monitor.log(
                    System.Logger.Level.INFO,
                    String.format(
                        "Status for Cromwell workflow %s on %s is %s",
                        state.getCromwellId(), baseUrl, result.getStatus()));
                switch (result.getStatus()) {
                  case "Aborted":
                  case "Failed":
                    monitor.permanentFailure("Cromwell failure: " + result.getStatus());
                    break;
                  case "Succeeded":
                    finish(state, monitor);
                    break;
                  default:
                    monitor.updateState(statusFromCromwell(result.getStatus()));
                    monitor.scheduleTask(5, TimeUnit.MINUTES, () -> check(state, monitor));
                }
              })
          .exceptionally(
              t -> {
                t.printStackTrace();
                monitor.log(
                    System.Logger.Level.WARNING,
                    String.format(
                        "Failed to get status for Cromwell workflow %s on %s",
                        state.getCromwellId(), baseUrl));
                CROMWELL_FAILURES.labels(baseUrl).inc();
                monitor.scheduleTask(5, TimeUnit.MINUTES, () -> check(state, monitor));
                return null;
              });
    } catch (Exception e) {
      e.printStackTrace();
      monitor.log(
          System.Logger.Level.WARNING,
          String.format(
              "Failed to get status for Cromwell workflow %s on %s",
              state.getCromwellId(), baseUrl));
      CROMWELL_FAILURES.labels(baseUrl).inc();
      monitor.scheduleTask(5, TimeUnit.MINUTES, () -> check(state, monitor));
    }
  }

  @Override
  protected Void cleanup(String cleanupState, WorkMonitor<Void, Void> monitor) {
    monitor.scheduleTask(() -> monitor.complete(null));
    return null;
  }

  @Override
  public void configuration(SectionRenderer sectionRenderer) throws XMLStreamException {
    sectionRenderer.link("Server", baseUrl, baseUrl);
  }

  @Override
  public Optional<SimpleType> engineParameters() {
    return Optional.empty();
  }

  private void finish(EngineState state, WorkMonitor<Result<String>, EngineState> monitor) {
    CROMWELL_REQUESTS.labels(baseUrl).inc();
    monitor.log(
        System.Logger.Level.INFO,
        String.format(
            "Reaping output of Cromwell workflow %s on %s", state.getCromwellId(), baseUrl));
    CLIENT
        .sendAsync(
            HttpRequest.newBuilder()
                .uri(
                    URI.create(
                        String.format(
                            "%s/api/workflows/v1/%s/outputs", baseUrl, state.getCromwellId())))
                .timeout(Duration.ofMinutes(1))
                .GET()
                .build(),
            new JsonBodyHandler<>(MAPPER, WorkflowOutputResponse.class))
        .thenApply(HttpResponse::body)
        .thenAccept(
            s -> {
              final var result = s.get();
              monitor.log(
                  System.Logger.Level.INFO,
                  String.format(
                      "Got output of Cromwell workflow %s on %s", state.getCromwellId(), baseUrl));
              monitor.complete(
                  new Result<>(
                      result.getOutputs(),
                      String.format(
                          "%s/api/workflows/v1/%s/metadata", baseUrl, state.getCromwellId()),
                      Optional.empty()));
            })
        .exceptionally(
            t -> {
              t.printStackTrace();
              monitor.log(
                  System.Logger.Level.INFO,
                  String.format(
                      "Failed to get output of Cromwell workflow %s on %s",
                      state.getCromwellId(), baseUrl));
              CROMWELL_FAILURES.labels(baseUrl).inc();
              monitor.scheduleTask(CHECK_DELAY, TimeUnit.MINUTES, () -> check(state, monitor));
              return null;
            });
  }

  @Override
  protected void recover(EngineState state, WorkMonitor<Result<String>, EngineState> monitor) {}

  @Override
  protected void recoverCleanup(Void state, WorkMonitor<Void, Void> monitor) {
    monitor.complete(null);
  }

  @Override
  protected EngineState runWorkflow(
      WorkflowLanguage workflowLanguage,
      String workflow,
      String vidarrId,
      ObjectNode workflowParameters,
      ObjectNode engineParameters,
      WorkMonitor<Result<String>, EngineState> monitor) {
    final var state = new EngineState();
    state.setEngineParameters(engineParameters);
    state.setParameters(workflowParameters);
    state.setWorkflowUrl(workflow);
    monitor.scheduleTask(
        () -> {
          try {
            monitor.log(
                System.Logger.Level.INFO,
                String.format("Starting Cromwell workflow on %s", baseUrl));
            final var body =
                new MultiPartBodyPublisher()
                    .addPart("workflowSource", state.getWorkflowUrl())
                    .addPart("workflowInputs", MAPPER.writeValueAsString(state.getParameters()))
                    .addPart("workflowType", "WDL")
                    .addPart(
                        "workflowTypeVersion",
                        switch (workflowLanguage) {
                          case WDL_1_0 -> "1.0";
                          case WDL_1_1 -> "1.1";
                          default -> "draft1";
                        })
                    .addPart(
                        "labels",
                        MAPPER.writeValueAsString(
                            Collections.singletonMap(
                                "vidarr-id",
                                vidarrId.substring(Math.max(0, vidarrId.length() - 255)))))
                    .addPart("workflowOptions", MAPPER.writeValueAsString(engineParameters));
            CROMWELL_REQUESTS.labels(baseUrl).inc();
            CLIENT
                .sendAsync(
                    HttpRequest.newBuilder()
                        .uri(URI.create(String.format("%s/api/workflows/v1", baseUrl)))
                        .timeout(Duration.ofMinutes(1))
                        .header("Content-Type", body.getContentType())
                        .POST(body.build())
                        .build(),
                    new JsonBodyHandler<>(MAPPER, WorkflowStatusResponse.class))
                .thenApply(HttpResponse::body)
                .thenAccept(
                    s -> {
                      final var result = s.get();
                      if (result.getId() == null) {
                        monitor.permanentFailure("Cromwell to launch workflow.");
                        return;
                      }
                      state.setCromwellId(result.getId());
                      monitor.updateState(statusFromCromwell(result.getStatus()));
                      monitor.scheduleTask(
                          CHECK_DELAY, TimeUnit.MINUTES, () -> check(state, monitor));
                      monitor.log(
                          System.Logger.Level.INFO,
                          String.format(
                              "Started Cromwell workflow %s on %s",
                              state.getCromwellId(), baseUrl));
                    })
                .exceptionally(
                    t -> {
                      monitor.log(
                          System.Logger.Level.INFO,
                          String.format("Failed to launch Cromwell workflow on %s", baseUrl));
                      t.printStackTrace();
                      CROMWELL_FAILURES.labels(baseUrl).inc();
                      monitor.scheduleTask(
                          CHECK_DELAY, TimeUnit.MINUTES, () -> check(state, monitor));
                      return null;
                    });
          } catch (Exception e) {
            monitor.log(
                System.Logger.Level.INFO,
                String.format("Failed to launch Cromwell workflow on %s", baseUrl));
            CROMWELL_FAILURES.labels(baseUrl).inc();
            monitor.permanentFailure(e.toString());
          }
        });
    return state;
  }
}
