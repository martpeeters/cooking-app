import '../Identifier.dart';
import '../../database/Assets.dart';
import 'Family.dart';

class Ingredient extends Identifier {
  Family family;

  String name;
  String country;
  String imageLink;

  Ingredient.fromJSON(Assets assets, Map<String, dynamic> json) : super(json['id']) {
    family = assets.family.get(json['family']['id']);

    this.name = json['name'];
    this.country = json['country'];
    this.imageLink = json['imageLink'];
  }

  @override
  String toString()
  {
    return name;
  }
}