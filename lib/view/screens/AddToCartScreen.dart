import 'package:flutter/material.dart';
import 'package:info2051_2018/view/screens/ShoppingCartScren.dart';
import '../../model/assets/dictionary/Ingredient.dart';
import '../../manager.dart';

class AddToCartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AddToCartScreenState();
}

class AddToCartScreenState extends State<AddToCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.6),
        appBar: new AppBar(
          backgroundColor: Colors.green,
          toolbarOpacity: 0.6,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(null),
            ),
          ],
        ),
      body: _createBarLayout(),
    );
  }

  Column _createBarLayout() {
    return new Column(
      children: <Widget>[
        Container(
          height: 90.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child:
                RaisedButton(
                    color: Colors.white,
                    child: new Row(
                      children: <Widget>[
                        Text("Search ...                                                             "
                            ,
                            style: TextStyle(color: Colors.black12)),
                        Icon(Icons.search),
                      ],
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () { showSearch(context: context, delegate: SearchBarData());
                    }
                ),
              ),
            ],
          ),
        ),
        Expanded(child: GestureDetector(
          onTap: () => Navigator.of(context).pop(null),
        )),
      ],
    );
  }
}

// SearchBar - Should be moved to shopping cart

class SearchBarData extends SearchDelegate<String> {

  int _iHistory = 0;
  int _maxHistory = 5;
  List<Ingredient> _history;

  SearchBarData() {
    _history  = new List(_maxHistory);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = "";
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(
        color: Colors.green,
        tooltip: 'Back',
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        },
      );

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Ingredient> suggestion = query.isEmpty
        ? _history
        : AppManager.instance.assets.ingredients.getInternal()
        .where((i) => i.name.startsWith(query.toLowerCase()));

    return ListView.builder(
      itemBuilder: (context, i) =>
          ListTile(
            onTap: () {
              _showToast(context, suggestion[i]);
            },
            leading: Icon(Icons.fastfood),
            title: Text(suggestion[i].name),
          ),
      itemCount: suggestion.length,
    );
  }

  void _addRecentIngredient(Ingredient ingredient) {
    _history[_iHistory] = ingredient;
    _iHistory = (_iHistory + 1) % (_maxHistory);
  }

  void _showToast(BuildContext context, Ingredient ingredient) {
    final scaffold = Scaffold.of(context);
    bool alreadyIn = AppManager.instance.shoppingCart.isBookmarked(ingredient);

    scaffold.showSnackBar(
      SnackBar(
        content: alreadyIn ? const Text('') : const Text("Add to your shopping list ?"),
        action: SnackBarAction(
            label: alreadyIn ? 'Already in your shopping list' : "YES",
             onPressed: alreadyIn ? () {} : ()
              {
                _addRecentIngredient(ingredient);
                AppManager.instance.shoppingCart.setBookmark(ingredient, true);
                ShoppingCartScreenState.updateShoppingCart();
              }
        ),
      ),
    );
  }
}
