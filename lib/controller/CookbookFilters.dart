import 'package:info2051_2018/model/Cookbook.dart';
import 'package:info2051_2018/model/assets/dictionary/Tag.dart';

import '../model/assets/dictionary/Ingredient.dart';
import '../model/assets/recipe/Quantity.dart';

import '../manager.dart';
import '../model/assets/filter/OptionalFilter.dart';

import '../model/assets/recipe/Recipe.dart';
import '../model/assets/filter/FilterChain.dart';

abstract class CookbookFilter extends OptionalFilter<BookmarkRecipe> {

  String name;
  CookbookFilter(name, enabled) : super(enabled);
}

// Recipes ingredients are in the fridge.
class FromFridgeFilter extends CookbookFilter {

  FromFridgeFilter(enabled) : super('From fridge', enabled);

  @override
  bool retainIfEnabled(Recipe r) {
    return r.ingredients.any((i) => AppManager.instance.fridge.isBookmarked(i.type));
  }
}

class QuickCookingFilter extends CookbookFilter {

  QuickCookingFilter(enabled) : super('Quick-cooking', enabled);

  @override
  bool retainIfEnabled(Recipe r) {
    return r.prepTime < 20;
  }
}

// Tags.
class FamilyFriendlyFilter extends CookbookFilter {

  FamilyFriendlyFilter(enabled) : super('Familly friendly', enabled);

  @override
  bool retainIfEnabled(Recipe r) {
    return r.tags.any((i) => i.getId() == 0);
  }
}

class VeggieFilter extends CookbookFilter {

  VeggieFilter(enabled) : super('Veggie', enabled);

  @override
  bool retainIfEnabled(Recipe r) {
    return r.tags.any((i) => i.getId() == 1);
  }
}

class OnePanFilter extends CookbookFilter {

  OnePanFilter(enabled) : super('One Pan', enabled);

  @override
  bool retainIfEnabled(Recipe r) {
    return r.tags.any((i) => i.getId() == 3);
  }
}

class OnePotFilter extends CookbookFilter {

  OnePotFilter(enabled) : super('One Pot', enabled);

  @override
  bool retainIfEnabled(Recipe r) {
    return r.tags.any((i) => i.getId() == 6);
  }
}

class GlutenFreeFilter extends CookbookFilter {

  GlutenFreeFilter(enabled) : super('Gluten free', enabled);

  @override
  bool retainIfEnabled(Recipe r) {
    return r.tags.any((i) => i.getId() == 7);
  }
}

class Under30MinutesFilter extends CookbookFilter {

  Under30MinutesFilter(enabled) : super('Under 30 Minutes', enabled);

  @override
  bool retainIfEnabled(Recipe r) {
    return r.tags.any((i) => i.getId() == 15);
  }
}

class CookbookFilters extends FilterChain<BookmarkRecipe, CookbookFilter> {

  CookbookFilters() {
    this.add(new FromFridgeFilter(false));
    this.add(new QuickCookingFilter(false));
    this.add(new FamilyFriendlyFilter(false));
    this.add(new VeggieFilter(false));
    this.add(new OnePanFilter(false));
    this.add(new OnePotFilter(false));
    this.add(new GlutenFreeFilter(false));
    this.add(new Under30MinutesFilter(false));
  }

  String getFilterName(int i) {
    return this.getFilter(i).name;
  }
}