import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:info2051_2018/model/assets/recipe/Quantity.dart';
import 'package:info2051_2018/view/screens/RecipesListScreen.dart';
import 'package:info2051_2018/view/screens/ShoppingCartScren.dart';

import '../../model/assets/dictionary/Ingredient.dart';
import '../../model/assets/recipe/Recipe.dart';
import '../../manager.dart';
import 'DirectionsScreen.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;
  RecipeScreen({Key key, @required this.recipe}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new RecipeScreenState();
}

class RecipeScreenState extends State<RecipeScreen> {
  int _yields = 1;

  RecipeScreenState() {
    _yields = widget.recipe.yields;
  }

  void addToCart(Quantity<Ingredient> q, BuildContext context) {
    final scaffold = Scaffold.of(context);

    bool isBookmarked = AppManager.instance.shoppingCart.isBookmarked(q.type);
    if(!isBookmarked)
      {
        AppManager.instance.shoppingCart.setBookmark(q.type, true);
        ShoppingCartScreenState.updateShoppingCart();
      }

    scaffold.showSnackBar(
      SnackBar(
        content: Text(isBookmarked ? 'Already in your Shopping Cart' : 'Added to your Shopping Cart'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Stack(
            children:[
            SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: new BorderRadius.only(
                            topLeft:  const  Radius.circular(20.0),
                            topRight: const  Radius.circular(20.0))
                        ),
                        child: AspectRatio(
                          aspectRatio: 16.0/9.0,
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
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,//Color(0xFFE1C699),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                          // Default value for crossAxisAlignment is CrossAxisAlignment.center.
                          // We want to align title and description of recipes left:
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child:Text(
                                widget.recipe.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Open Sans',
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),// Empty space:
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Icon(Icons.timer, color: Colors.white, size: 20.0),
                                  SizedBox(width: 5.0),
                                  Text(
                                    widget.recipe.prepTime.toString() + ' min',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: RaisedButton(
                                        color: Colors.black26,
                                        splashColor: Colors.brown,
                                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new DirectionsScreen(recipe:widget.recipe))),
                                        child: Text(
                                          "Get Directions",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Open Sans',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "Ingredients:",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: 'Open Sans',
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: FlatButton.icon(
                              icon: new Icon(Icons.add_circle_outline, color: Colors.black45),
                              onPressed: () => _yields++,
                              label: AutoSizeText(
                                "Serving(s): " + _yields.toString(),
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: 'Open Sans',
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.recipe.ingredients.length,
                          padding: EdgeInsets.only(
                              top: 10.0, left: 0.0, right: 20.0, bottom: 5.0),
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child:FittedBox(
                                fit: BoxFit.fitWidth,
                                child: FlatButton.icon(
                                  icon: new Icon(Icons.add_circle_outline, color: Colors.black45),
                                  onPressed: () => addToCart(widget.recipe.ingredients[index], context),
                                  label: AutoSizeText(
                                    widget.recipe.ingredients[index].toString(),
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontFamily: 'Open Sans',
                                        fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                      ),

                    ]
                  ),

                ],
              ),
            ),
            Container(
              color: Color(0x55000000), //56BA58
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: new Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  RawMaterialButton(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}