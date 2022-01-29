import 'database/Storable.dart';

class Settings extends Storable {

  bool _offline = false;

  Settings() : super('settings');

  void setOffline(bool value) {
    _offline = value;
  }

  bool isOffline() {
    return _offline;
  }

  @override
  void loadObject(Map<String, dynamic> obj) {
    _offline = obj['offline'] == 'true' ? true : false;
  }

  @override
  Map<String, dynamic> saveObject() {
    Map<String, dynamic> obj = new Map();
    obj['offline'] = _offline ? 'true' : 'false';

    return obj;
  }

  @override
  void reset() {
    _offline = false;
  }

}