import 'dart:async';

import 'model/Cookbook.dart';
import 'model/Fridge.dart';
import 'model/Settings.dart';
import 'model/ShoppingCart.dart';
import 'model/database/Assets.dart';
import 'model/database/Database.dart';

enum AppState {
  Starting,
  LoadingAssets,
  ProcessingAssets,
  LoadingDatabase,
  LoadingComplete,
}

// Singleton
class AppManager {

  AppState state;
  StreamController<AppState> _stateController;
  Stream get onStateChanged => _stateController.stream;

  Assets assets;
  Database database;
  Cookbook cookbook;
  Fridge fridge;
  ShoppingCart shoppingCart;
  Settings settings;

  // Internal
  static final AppManager _instance = AppManager._internal();
  static AppManager get instance { return _instance;}

  // Load & Instantiate
  AppManager._internal() {

    _stateController = new StreamController<AppState>();
    _setState(AppState.Starting);

    // Instantiation
    assets = new Assets();
    database = new Database();
    cookbook = new Cookbook();
    fridge = new Fridge();
    shoppingCart = new ShoppingCart();
    settings = new Settings();

    // Database subscription
    database.subscribeAll([cookbook, fridge, shoppingCart, settings]);

    // Load assets
    state = AppState.LoadingAssets;
    assets.load(Language.English, cookbook, fridge)
        .then((_) { _setState(AppState.ProcessingAssets); return _processAssets();})
        .then((_) { _setState(AppState.LoadingDatabase); return _loadDatabase();})
        .then((_) { _setState(AppState.LoadingComplete); _stateController.close(); });
  }

  Future<void> _processAssets() async {
    cookbook.addAll(assets.recipes.getInternal());
    fridge.addAll(assets.ingredients.getInternal());
    shoppingCart.addAll(assets.ingredients.getInternal());
  }

  Future<void> _loadDatabase() async {
    await database.initiate();
    database.load();
  }

  void _setState(AppState s) {
    state = s;
    _stateController.add(s);
  }
}