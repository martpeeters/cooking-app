import 'assets/dictionary/Ingredient.dart';

import 'assets/dictionary/Dictionary.dart';
import 'assets/filter/AndFilter.dart';
import 'assets/filter/Filter.dart';
import 'database/Storable.dart';

import 'assets/Bookmark.dart';
import 'database/Assets.dart';

mixin BookmarkIngredient implements Bookmark, Ingredient {}

class Fridge extends Storable {
  Dictionary<BookmarkIngredient> _fridge;

  Fridge() : super('fridge') {
    _fridge = new Dictionary<BookmarkIngredient>();
  }

  void add(Ingredient i) {
    _fridge.add(i);
  }

  void addAll(List<Ingredient> ingredients) {
    for (Ingredient i in ingredients)
      _fridge.add(i);
  }

  bool isBookmarked(Ingredient i)
  {
    return _fridge.get(i.getId()).bookmarked;
  }

  void setBookmark(Ingredient i, bool value)
  {
    _fridge.get(i.getId()).bookmarked = value;
  }

  List<Ingredient> filter() {
    return _fridge.filter(new BookmarkFilter());
  }

  List<Ingredient> getInternal() {
    return _fridge.getInternal();
  }

  @override
  void loadObject(Map<String, dynamic> obj) {
    obj.forEach((k, v) => _fridge.get(int.parse(k)).bookmarked = (v == 'true' ? true : false));
  }

  @override
  Map<String, dynamic> saveObject() {
    Map<String, dynamic> obj = new Map();
    for (BookmarkIngredient i in _fridge.getInternal())
      obj[i.getId().toString()] = i.bookmarked ? 'true' : 'false';

    return obj;
  }

  @override
  void reset() {
    for (BookmarkIngredient i in _fridge.getInternal())
      i.bookmarked = false;
  }

}