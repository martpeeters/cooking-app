import 'package:info2051_2018/model/assets/dictionary/Ingredient.dart';

import 'assets/Bookmark.dart';
import 'database/Storable.dart';

import 'assets/filter/AndFilter.dart';

import 'assets/dictionary/Dictionary.dart';

import 'assets/filter/Filter.dart';
import 'assets/recipe/Recipe.dart';

mixin BookmarkRecipe implements Bookmark, Recipe {}

class Cookbook extends Storable {
  Dictionary<BookmarkRecipe> _recipes;

  Cookbook() : super('cookbook') {
    _recipes = new Dictionary<BookmarkRecipe>();
  }

  void add(Recipe r) {
    _recipes.add(r);
  }

  void addAll(List<Recipe> recipes) {
    for (Recipe r in recipes)
      _recipes.add(r);
  }

  bool isBookmarked(Recipe r)
  {
    return _recipes.get(r.getId()).bookmarked;
  }

  void setBookmark(Recipe r, bool value)
  {
    _recipes.get(r.getId()).bookmarked = value;
  }

  List<Recipe> filter(Filter<BookmarkRecipe> filter, bool bookmarkOnly) {
    if (bookmarkOnly)
      return _recipes.filter(new AndFilter<BookmarkRecipe>(filter, new BookmarkFilter()));
    else
      return _recipes.filter(filter);
  }

  @override
  void loadObject(Map<String, dynamic> obj) {
    obj.forEach((k, v) => _recipes.get(int.parse(k)).bookmarked = (v == 'true' ? true : false));
  }

  @override
  Map<String, dynamic> saveObject() {
    Map<String, dynamic> obj = new Map();
    for (BookmarkRecipe r in _recipes.getInternal())
      obj[r.getId().toString()] = r.bookmarked ? 'true' : 'false';

    return obj;
  }

  @override
  void reset() {
    for (BookmarkRecipe r in _recipes.getInternal())
      r.bookmarked = false;
  }
}