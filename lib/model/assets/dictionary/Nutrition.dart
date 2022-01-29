import '../Identifier.dart';
import '../../database/Assets.dart';

class Nutrition extends Identifier {
  String name;

  Nutrition.fromJSON(Assets assets, Map<String, dynamic> json) : super(json['id']) {
    this.name = json['name'];
  }

  @override
  String toString()
  {
    return name;
  }
}