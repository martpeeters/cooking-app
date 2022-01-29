import '../dictionary/Ingredient.dart';
import '../dictionary/Nutrition.dart';
import '../dictionary/Utensil.dart';
import '../dictionary/Tag.dart';
import '../dictionary/Cuisine.dart';
import '../../database/Assets.dart';
import '../Identifier.dart';
import 'Quantity.dart';
import 'Step.dart';

class Recipe extends Identifier {

  String name;
  String country;
  String headline;
  String description;
  int difficulty;
  int servingSize;
  int prepTime; // minutes
  String imageLink;

  int yields;
  List<Quantity<Nutrition>> nutrition = [];
  List<Quantity<Ingredient>> ingredients = [];

  List<Utensil> utensils = [];
  List<Tag> tags = [];
  List<Cuisine> cuisines =  [];

  List<Step> steps = [];

  Recipe.fromJSON(Assets assets, Map<String, dynamic> json) : super(json['id']) {
    this.name = json['name'];
    this.headline = json['headline'];
    this.description = json['description'];
    this.difficulty = json['difficulty'];
    this.servingSize = json['servingSize'];
    this.prepTime = int.parse(json['prepTime'].replaceAll('PT', '').replaceAll('M',''));
    this.imageLink = json['imageLink'];

    this.yields = json['yields']['yields'];
    for (Map<String, dynamic> n in json['nutrition'])
      nutrition.add(new Quantity<Nutrition>(n['amount'], n['unit'], assets.nutrition.get(n['id'])));

    for (Map<String, dynamic> i in json['yields']['ingredients'])
      ingredients.add(new Quantity<Ingredient>(i['amount'], i['unit'], assets.ingredients.get(i['id'])));

    for (Map<String, dynamic> u in json['utensils'])
      utensils.add(assets.utensils.get(u['id']));

    for (Map<String, dynamic> t in json['tags'])
      tags.add(assets.tags.get(t['id']));

    for (Map<String, dynamic> c in json['cuisines'])
      cuisines.add(assets.cuisines.get(c['id']));

    for (Map<String, dynamic> s in json['steps'])
      steps.add(Step.fromJSON(assets, s));
  }

}