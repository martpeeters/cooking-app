import '../Identifier.dart';
import '../../database/Assets.dart';

class Tag extends Identifier {
  String name;
  String imageLink;

  Tag.fromJSON(Assets assets, Map<String, dynamic> json) : super(json['id']) {
    this.name = json['name'];
    this.imageLink = json['imageLink'];
  }
}