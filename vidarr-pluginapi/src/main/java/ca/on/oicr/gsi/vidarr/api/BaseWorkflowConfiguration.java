package ca.on.oicr.gsi.vidarr.api;

import ca.on.oicr.gsi.vidarr.InputType;
import ca.on.oicr.gsi.vidarr.OutputType;
import ca.on.oicr.gsi.vidarr.WorkflowLanguage;
import java.util.Collections;
import java.util.Map;

/** JSON representation of a workflow definition */
public abstract class BaseWorkflowConfiguration {

  private Map<String, String> accessoryFiles = Collections.emptyMap();
  private WorkflowLanguage language;
  private Map<String, OutputType> outputs;
  private Map<String, InputType> parameters;
  private String workflow;

  public Map<String, String> getAccessoryFiles() {
    return accessoryFiles;
  }

  public final WorkflowLanguage getLanguage() {
    return language;
  }

  public final Map<String, OutputType> getOutputs() {
    return outputs;
  }

  public final Map<String, InputType> getParameters() {
    return parameters;
  }

  public final String getWorkflow() {
    return workflow;
  }

  public void setAccessoryFiles(Map<String, String> accessoryFiles) {
    this.accessoryFiles = accessoryFiles;
  }

  public final void setLanguage(WorkflowLanguage language) {
    this.language = language;
  }

  public final void setOutputs(Map<String, OutputType> outputs) {
    this.outputs = outputs;
  }

  public final void setParameters(Map<String, InputType> parameters) {
    this.parameters = parameters;
  }

  public final void setWorkflow(String workflow) {
    this.workflow = workflow;
  }
}
