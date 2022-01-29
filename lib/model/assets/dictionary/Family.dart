import '../Identifier.dart';
import '../../database/Assets.dart';
import 'Category.dart';

class Family extends Identifier {
  String name;
  String imageLink;
  Category category;

  Family.fromJSON(Assets assets, Map<String, dynamic> json) : super(json['id']) {

    category = assets.categories.get(json['category']['id']);

    this.name = json['name'];
    this.imageLink = json['imageLink'];
  }
}