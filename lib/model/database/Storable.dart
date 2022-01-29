abstract class Storable {

  String _objName;

  Storable(String name)
  {
    _objName = name;
  }

  void loadObject(Map<String, dynamic> obj);
  Map<String, dynamic> saveObject();
  void reset();

  String getName() {
    return _objName;
  }
}