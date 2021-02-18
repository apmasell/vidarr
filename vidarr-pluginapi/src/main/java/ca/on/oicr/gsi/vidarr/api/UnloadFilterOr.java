package ca.on.oicr.gsi.vidarr.api;

import ca.on.oicr.gsi.vidarr.UnloadFilter;
import java.util.List;

public final class UnloadFilterOr implements UnloadFilter {

  private List<UnloadFilter> filters;

  @Override
  public <T> T convert(Visitor<T> visitor) {
    return visitor.or(filters.stream().map(f -> f.convert(visitor)));
  }

  public List<UnloadFilter> getFilters() {
    return filters;
  }

  public void setFilters(List<UnloadFilter> filters) {
    this.filters = filters;
  }
}
