import '../Identifier.dart';
import '../../database/Assets.dart';

class Category extends Identifier {
  String name;
  String imageLink;

  Category.fromJSON(Assets assets, Map<String, dynamic> json) : super(json['id']) {
    this.name = json['name'];
    this.imageLink = json['imageLink'];
  }
}