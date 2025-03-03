import ca.on.oicr.gsi.vidarr.ConsumableResourceProvider;
import ca.on.oicr.gsi.vidarr.prometheus.AlertmanagerAutoInhibitConsumableResource;

module ca.on.oicr.gsi.vidarr.prometheus {
  requires ca.on.oicr.gsi.vidarr.pluginapi;
  requires com.fasterxml.jackson.core;
  requires com.fasterxml.jackson.databind;
  requires java.net.http;

  opens ca.on.oicr.gsi.vidarr.prometheus to
      com.fasterxml.jackson.core,
      com.fasterxml.jackson.databind;

  provides ConsumableResourceProvider with
      AlertmanagerAutoInhibitConsumableResource;
}
