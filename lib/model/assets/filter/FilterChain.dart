import 'package:info2051_2018/model/assets/filter/OptionalFilter.dart';

import 'Filter.dart';

class FilterChain<T, U extends OptionalFilter<T>> extends Filter<T> {

  List<U> chain = [];

  @override
  bool retain(T t) {
    if (chain.isEmpty)
      return true;

    for(Filter c in chain)
      if (!c.retain(t))
        return false;

    return true;
  }

  void add(U filter) {
    chain.add(filter);
  }

  void addAll(List<U> filters) {
    for (U f in filters)
      chain.add(f);
  }

  void remove(U filter) {
    chain.remove(filter);
  }

  void enableFilter(int i) {
    chain[i].enable();
  }

  void disableFilter(int i) {
    chain[i].disable();
  }

  bool isFilterEnabled(int i) {
    chain[i].isEnabled();
  }

  U getFilter(int i) {
    return chain[i];
  }

  List<U> getInternal() {
    return chain;
  }

  int getLength() {
    return chain.length;
  }
}