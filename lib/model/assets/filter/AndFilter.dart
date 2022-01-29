import 'Filter.dart';

class AndFilter<T> extends Filter<T> {
  Filter<T> a;
  Filter<T> b;

  AndFilter(this.a, this.b);

  @override
  bool retain(T t) {
    return a.retain(t) && b.retain(t);
  }

}