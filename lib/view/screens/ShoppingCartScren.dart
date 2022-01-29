import 'package:flutter/material.dart';

import '../../manager.dart';
import '../../model/assets/dictionary/Ingredient.dart';
import 'AddToCartScreen.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ShoppingCartScreenState();
}

class ShoppingCartScreenState extends State<ShoppingCartScreen> {
  static List<Ingredient> _grocery;

  ShoppingCartScreenState() {
    updateShoppingCart();
  }

  static void updateShoppingCart() {
    _grocery = AppManager.instance.shoppingCart.filter();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          title: new Text("Shopping Cart"),
          backgroundColor: Colors.green,
          actions: <Widget>[_buildPopUpMenu()],
        ),
        body: ListView.builder(
          itemCount: AppManager.instance.assets.categories.getLength(),
          itemBuilder: (context, index) {
            return new Column(children: _addShoppingCartContent(index));
          },
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () => Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) => AddToCartScreen())),
          child: new Icon(Icons.add),
          backgroundColor: Colors.green,
        ));
  }

  List<Widget> _addShoppingCartContent(int index) {
    List<Widget> widgets = [];
    widgets.add(new Container(
        height: 50.0,
        child: ListTile(
          title: Text(
            AppManager.instance.assets.categories.get(index).name,
          ),
        )));

    widgets.addAll(_grocery
        .where((i) => i.family.category.getId() == index)
        .map((i) => new Container(
              height: 60.0,
              margin: new EdgeInsets.only(top: 0.0, left: 30.0),
              child: ListTile(
                  title: Text(
                    i.name,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  subtitle: new Text(
                      i.country),
                  onLongPress: () {
                    _confirmDialog(context, i);
                  }),
            )));

    return widgets;
  }

  void _actionChoice(String choice) {
    setState(() {
      if (choice == "Delete") {
        AppManager.instance.shoppingCart.reset();
        updateShoppingCart();
      }
      else if (choice == "Fridge") {
        AppManager.instance.fridge.addAll(_grocery);
        AppManager.instance.shoppingCart.reset();
        updateShoppingCart();
      }
    });
  }

  _buildPopUpMenu() {
    return PopupMenuButton(
      onSelected: _actionChoice,
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
            child: const Text('Delete All'), value: 'Delete'),
        new PopupMenuItem<String>(
            child: const Text('Add All To Fridge'), value: 'Fridge'),
      ],
    );
  }

  _confirmDialog(BuildContext context, Ingredient ingredient) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item ?'),
          content: const Text(
              'This will delete the selected item from the shopping list.'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            FlatButton(
              child: const Text('PROCEED'),
              onPressed: () {
                setState(() {
                  AppManager.instance.shoppingCart.setBookmark(ingredient, false);
                  updateShoppingCart();
                  Navigator.of(context).pop(null);
                });
              },
            )
          ],
        );
      },
    );
  }
}
