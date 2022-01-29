import 'package:flutter/material.dart';
import 'package:info2051_2018/manager.dart';
import 'FridgeScreen.dart';
import 'ShoppingCartScren.dart';
import 'SettingsScreen.dart';

import 'RecipesListScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  AppLifecycleState _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      switch (state) {
        case AppLifecycleState.inactive:
          break;
        case AppLifecycleState.paused:
          AppManager.instance.database.save();
          break;
        case AppLifecycleState.suspending:
          break;
        case AppLifecycleState.resumed:
          AppManager.instance.database.load();
          break;
      }
      _lastLifecycleState = state;
      print(_lastLifecycleState);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //color: Colors.red,
      home: SafeArea(
        child: DefaultTabController(
          length: 5,
          child: new Scaffold(
            body: TabBarView(
              children: [
                new RecipesListScreen(isFavScreen: false), // We use the same screen for this screen and the one below to re-use code
                new RecipesListScreen(isFavScreen: true), // Only change is that this one is a "Favourite Recipes Screen" so we pass a boolean
                new FridgeScreen(),
                new ShoppingCartScreen(),
                new SettingsScreen(),
              ],
            ),
            bottomNavigationBar: new TabBar(
              tabs: [
                Tab(
                  icon: new Icon(Icons.list),
                ),
                Tab(
                  icon: new Icon(Icons.favorite),
                ),
                Tab(
                  icon: new Icon(Icons.kitchen),
                ),
                Tab(
                  icon: new Icon(Icons.shopping_cart),
                ),
                Tab(icon: new Icon(Icons.account_circle),
                )
              ],
              labelColor: Colors.green,
              unselectedLabelColor: Colors.green,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(2.0),
              indicatorColor: Colors.lightGreen,
            ),
            //backgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}

