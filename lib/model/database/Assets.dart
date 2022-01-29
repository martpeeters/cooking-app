import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:info2051_2018/model/assets/recipe/Recipe.dart';

import '../assets/dictionary/Dictionary.dart';
import '../assets/dictionary/Category.dart';
import '../assets/dictionary/Cuisine.dart';
import '../assets/dictionary/Family.dart';
import '../assets/dictionary/Ingredient.dart';
import '../assets/dictionary/Nutrition.dart';
import '../assets/dictionary/Tag.dart';
import '../assets/dictionary/Utensil.dart';

import '../Fridge.dart';
import '../Cookbook.dart';

enum Language {
  English
}

class Assets {
  Dictionary<Recipe> recipes = new Dictionary<Recipe>();

  Dictionary<Category> categories = new Dictionary<Category>();
  Dictionary<Cuisine> cuisines = new Dictionary<Cuisine>();
  Dictionary<Family> family = new Dictionary<Family>();
  Dictionary<Ingredient> ingredients = new Dictionary<Ingredient>();
  Dictionary<Nutrition> nutrition = new Dictionary<Nutrition>();
  Dictionary<Tag> tags = new Dictionary<Tag>();
  Dictionary<Utensil> utensils = new Dictionary<Utensil>();

  Future<void> load(Language l, Cookbook cookbook, Fridge fridge) async {
    if (l != Language.English)
      print("Assets: unhandled language $l, english set.");

    _processDictionary(jsonDecode(await _loadAsset('assets/en', 'dictionary.json')));
    _processRecipes(jsonDecode(await _loadAsset('assets/en', 'recipes.json')));
  }

  void _processDictionary(Map<String, dynamic> json)
  {
    for (Map<String, dynamic> c in json['categories'])
      categories.add(Category.fromJSON(this, c));

    for (Map<String, dynamic> c in json['cuisines'])
      cuisines.add(Cuisine.fromJSON(this, c));

    for (Map<String, dynamic> n in json['nutrition'])
      nutrition.add(Nutrition.fromJSON(this, n));

    for (Map<String, dynamic> t in json['tags'])
      tags.add(Tag.fromJSON(this, t));

    for (Map<String, dynamic> u in json['utensils'])
      utensils.add(Utensil.fromJSON(this, u));

    for (Map<String, dynamic> f in json['family'])
      family.add(Family.fromJSON(this, f));

    for (Map<String, dynamic> i in json['ingredients'])
      ingredients.add(Ingredient.fromJSON(this, i));
  }

  void _processRecipes(List<Map<String, dynamic>> json)
  {
    for (Map<String, dynamic> r in json)
      recipes.add(Recipe.fromJSON(this, r));
  }

  Future<String> _loadAsset(String path, String filename) async {
    return await rootBundle.loadString('$path/$filename');
  }
}