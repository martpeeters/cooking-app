import '../Identifier.dart';
import '../../database/Assets.dart';

class Utensil extends Identifier {
  String name;

  Utensil.fromJSON(Assets assets, Map<String, dynamic> json) : super(json['id']) {
    this.name = json['name'];
  }
}