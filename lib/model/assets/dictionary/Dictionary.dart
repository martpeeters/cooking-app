import '../filter/Filter.dart';

import '../Identifier.dart';

class Dictionary<T extends Identifier> {

  List<T> _internal;

  Dictionary() {
    _internal = new List();
  }

  T get(int id) {
    return _internal[id];
  }

  void add(T obj) {
    _internal.insert(obj.getId(), obj);
  }

  List<T> filter(Filter<T> filter) {
    return _internal.where(filter.retain).toList();
  }

  int getLength() {
    return _internal.length;
  }

  List<T> getInternal() {
    return _internal;
  }
}