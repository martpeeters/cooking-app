import 'package:flutter/material.dart';
import '../../controller/CookbookFilters.dart';
import '../../manager.dart';
import '../../model/assets/recipe/Recipe.dart';
import 'RecipeCard.dart';

class RecipesListScreen extends StatefulWidget {
  final bool isFavScreen;
  RecipesListScreen({Key key, @required this.isFavScreen}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new RecipesListScreenState(isFavScreen);
}

class RecipesListScreenState extends State<RecipesListScreen> {
  static CookbookFilters _filters;
  static List<Recipe> _recipes;
  static bool isFavScreen;

  RecipesListScreenState(isFavScreen) {
    _filters = new CookbookFilters();
    updateRecipes();
  }

  static void updateRecipes() {
    _recipes = AppManager.instance.cookbook.filter(_filters, isFavScreen);
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 40.0, bottom: 20.0),
            height: 50.0,
            child:
                ListView.builder(
                      itemCount: _filters.getLength(),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 5.0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child:
                          RaisedButton(
                              child: new Text(
                                  _filters.getFilterName(index), style: TextStyle(color: Colors.white)),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0)),
                              color: _filters.isFilterEnabled(index) ? Colors.blue : Colors.green,
                              //splashColor: Colors.lightGreen,
                              onPressed: () {setState(() {
                                if (_filters.isFilterEnabled(index))
                                  _filters.disableFilter(index);
                                else
                                  _filters.enableFilter(index);

                                updateRecipes();
                              });}
                          ),
                        );
                      }
                  ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (BuildContext context, int index) {
                return new RecipeCard(
                  recipe: _recipes[index],
                );
              },
            ),
          ),
        ],
      );
    }
  }