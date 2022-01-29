import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:info2051_2018/view/screens/RecipesListScreen.dart';

import '../../manager.dart';
import '../../model/assets/recipe/Recipe.dart';
import 'RecipeScreen.dart';

class RecipeCard extends StatefulWidget {

  final Recipe recipe;

  RecipeCard({Key key, @required this.recipe}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new RecipeCardState();
}

class RecipeCardState extends State<RecipeCard> {

  @override
  Widget build(BuildContext context) {
    RawMaterialButton _buildFavoriteButton() {
      return RawMaterialButton(
        constraints: const BoxConstraints(minWidth: 30.0, minHeight: 30.0, maxHeight: 70),
        onPressed: () {setState(() {
          if (AppManager.instance.cookbook.isBookmarked(widget.recipe))
            AppManager.instance.cookbook.setBookmark(widget.recipe, false);
          else
            AppManager.instance.cookbook.setBookmark(widget.recipe, true);

          RecipesListScreenState.updateRecipes();
        });},
        child: Icon(
          AppManager.instance.cookbook.isBookmarked(widget.recipe)
              ? Icons.favorite : Icons.favorite_border,
        ),
        elevation: 2.0,
        fillColor: Colors.white,
        shape: CircleBorder(),
      );
    }

    Padding _buildTitleSection() {
      return Padding(

        padding: EdgeInsets.all(15.0),
        child: Column(
          // Default value for crossAxisAlignment is CrossAxisAlignment.center.
          // We want to align title and description of recipes left:
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                new Container(
                  width: 180.0,
                  child: Text(widget.recipe.name),
                ),
                new Container(
                  width: 100.0,
                  child: Text(widget.recipe.headline),
                )
              ],
            ),

            // Empty space:
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.timer, size: 20.0),
                SizedBox(width: 5.0),
                new Container(
                  width: 160.0,
                  child: new Text(widget.recipe.prepTime.toString() +  'min')
                ),
                new Container(
                  width: 70.0,
                  child: Text(widget.recipe.nutrition[0].toString()),
                )
              ],
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new RecipeScreen(recipe: this.widget.recipe,))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Card(
          //shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // We overlap the image and the button by
              // creating a Stack object:
              Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Center(
                        child:
                          SizedBox(
                            child: CircularProgressIndicator(),
                            height: 50.0,
                            width: 50.0,
                          )
                      ),
                      imageUrl: this.widget.recipe.imageLink,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: _buildFavoriteButton(),
                    top: 1.0,
                    right: 1.0,
                  ),
                ],
              ),
              _buildTitleSection(),
            ],
          ),
        ),
      ),
    );
  }
}