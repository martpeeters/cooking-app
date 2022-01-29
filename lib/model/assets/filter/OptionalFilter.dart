import 'Filter.dart';

abstract class OptionalFilter<T> extends Filter<T> {

  bool retainIfEnabled(T t);

  bool _enabled;
  OptionalFilter(_enabled);

  @override
  bool retain(T t) {
    return !_enabled || retainIfEnabled(t);
  }

  void enable() {
    _enabled = true;
  }

  void disable() {
    _enabled = false;
  }

  bool isEnabled() {
    return _enabled;
  }
}