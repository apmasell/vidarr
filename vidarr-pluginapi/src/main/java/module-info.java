import ca.on.oicr.gsi.vidarr.ConsumableResourceProvider;
import ca.on.oicr.gsi.vidarr.InputProvisionerProvider;
import ca.on.oicr.gsi.vidarr.OutputProvisionerProvider;
import ca.on.oicr.gsi.vidarr.RuntimeProvisionerProvider;
import ca.on.oicr.gsi.vidarr.UnloadFilterProvider;
import ca.on.oicr.gsi.vidarr.WorkflowEngineProvider;

/**
 * The API plugins are expected to implement
 *
 * <p>Vidarr uses plugins to communicate with external services. This module defines the APIs that
 * plugins are expected to provide as well as accessory data required or provided.
 */
module ca.on.oicr.gsi.vidarr.pluginapi {
  uses UnloadFilterProvider;
  uses WorkflowEngineProvider;
  uses ConsumableResourceProvider;
  uses InputProvisionerProvider;
  uses OutputProvisionerProvider;
  uses RuntimeProvisionerProvider;

  exports ca.on.oicr.gsi.vidarr;
  exports ca.on.oicr.gsi.vidarr.api;

  opens ca.on.oicr.gsi.vidarr.api to
      com.fasterxml.jackson.annotation,
      com.fasterxml.jackson.core,
      com.fasterxml.jackson.databind,
      com.fasterxml.jackson.datatype.jsr310;

  requires transitive ca.on.oicr.gsi.serverutils;
  requires transitive com.fasterxml.jackson.core;
  requires transitive com.fasterxml.jackson.databind;
  requires transitive com.fasterxml.jackson.datatype.jsr310;
  requires java.xml;
  requires java.net.http;
}
