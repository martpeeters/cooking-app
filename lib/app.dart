import 'package:flutter/material.dart';
import 'view/screens/FridgeScreen.dart';
import 'view/screens/MainScreen.dart';
import 'view/screens/RecipeScreen.dart';

import 'view/screens/LoadingScreen.dart';

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(
        primaryColor: Colors.green
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/fridge' : (context) => FridgeScreen(),
        '/recipe' : (context) => RecipeScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}