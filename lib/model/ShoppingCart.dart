import 'assets/dictionary/Ingredient.dart';

import 'assets/dictionary/Dictionary.dart';
import 'assets/filter/AndFilter.dart';
import 'assets/filter/Filter.dart';
import 'assets/recipe/Quantity.dart';
import 'database/Storable.dart';

import 'assets/Bookmark.dart';
import 'database/Assets.dart';

mixin BookmarkProduct implements Bookmark, Ingredient {
  int yields;
  Quantity<Ingredient> quantity;
}

class ShoppingCart extends Storable {
  Dictionary<BookmarkProduct> _grocery;

  ShoppingCart() : super('shoppingcart') {
    _grocery = new Dictionary<BookmarkProduct>();
  }

  void add(Ingredient i) {
    _grocery.add(i);
  }

  void addAll(List<Ingredient> ingredients) {
    for (Ingredient i in ingredients)
      _grocery.add(i);
  }

  bool isBookmarked(Ingredient i)
  {
    return _grocery.get(i.getId()).bookmarked;
  }

  void setBookmark(Ingredient i, bool value)
  {
    _grocery.get(i.getId()).bookmarked = value;
  }

  List<Ingredient> filter() {
      return _grocery.filter(new BookmarkFilter());
  }

  @override
  void loadObject(Map<String, dynamic> obj) {
    obj.forEach((k, v) => _grocery.get(int.parse(k)).bookmarked = (v == 'true' ? true : false));
  }

  @override
  Map<String, dynamic> saveObject() {
    Map<String, dynamic> obj = new Map();
    for (BookmarkProduct p in _grocery.getInternal())
      obj[p.getId().toString()] = p.bookmarked ? 'true' : 'false';

    return obj;
  }

  @override
  void reset() {
    for (BookmarkProduct p in _grocery.getInternal())
      p.bookmarked = false;
  }

}