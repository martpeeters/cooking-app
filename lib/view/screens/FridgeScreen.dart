import 'package:flutter/material.dart';
import 'package:info2051_2018/manager.dart';
import 'package:info2051_2018/model/assets/dictionary/Ingredient.dart';
import 'FridgeCategoriesScreen.dart';
import 'FridgeContentScreen.dart';

class FridgeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new FridgeScreenState();
}

class FridgeScreenState extends State<FridgeScreen> {
  @override
  Widget build(BuildContext context) {
    String mainTitle = "Fill up your fridge !";

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            bottom: TabBar(
              tabs: [
                new Tab(text:
                    "Select your ingredients"),
                new Tab(text :
                "My Fridge"),
              ],
            indicatorColor: Colors.white,
            ),
            title: Text(mainTitle),
          ),
          body: TabBarView(
            children: [
              new FridgeCategoriesScreen(),
              new FridgeContentScreen(),
            ],
          ),
        ),
      ),
    );
    }
}


