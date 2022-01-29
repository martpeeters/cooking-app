import '../dictionary/Ingredient.dart';
import '../dictionary/Utensil.dart';
import '../../database/Assets.dart';
import 'Timer.dart';

class Step {

  int index;
  String instructions;

  List<Timer> timers = [];
  List<String> images = [];
  List<Ingredient> ingredients = [];
  List<Utensil> utensils = [];

  Step.fromJSON(Assets assets, Map<String, dynamic> json) {
    this.index = json['index'];
    this.instructions = json['instructions'];

    for (Map<String, dynamic> t in json['timers'])
      timers.add(Timer.fromJSON(assets, t));

    for (Map<String, dynamic> i in json['images'])
      images.add(i['imageLink']);

    for (Map<String, dynamic> i in json['ingredients'])
      ingredients.add(assets.ingredients.get(i['id']));

    for (Map<String, dynamic> u in json['utensils'])
      utensils.add(assets.utensils.get(u['id']));
  }
}