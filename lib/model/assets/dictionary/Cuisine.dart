import '../Identifier.dart';
import '../../database/Assets.dart';

class Cuisine extends Identifier {
  String name;
  String imageLink;

  Cuisine.fromJSON(Assets assets, Map<String, dynamic> json) : super(json['id']) {
    this.name = json['name'];
    this.imageLink = json['imageLink'];
  }
}