import 'dart:async';

import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class LocalStore {

  Completer<Box> favoriteBoxCompleter = Completer<Box>();

  LocalStore() {
    _init();
  }

  void _init() async {
    print('==== Initializing local store ====');
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    print('== Registering Adapters...');
    Hive.registerAdapter(DrinkModelAdapter(), 0);

    print('== Opening boxes...');
    final box = await Hive.openBox('favorite-drinks');

    if (!favoriteBoxCompleter.isCompleted)
      favoriteBoxCompleter.complete(box);

    print('== Done. Local Store Initialized!');
  }

  void addFavoriteDrink(DrinkModel drink) async {
    final box = await favoriteBoxCompleter.future;
    box.put(drink.drinkId, drink);
  }

  void removeFavoriteDrink(String drinkId) async {
    final box = await favoriteBoxCompleter.future;
    box.delete(drinkId);
  }

  Future<DrinkModel> getFavoriteDrink(String drinkId) async {
    final box = await favoriteBoxCompleter.future;
    DrinkModel drinkModel = box.get(drinkId);
    return drinkModel;
  }

  Future<bool> isDrinkFavorite(String drinkId) async {
    await favoriteBoxCompleter.future;
    final isFavorite = await getFavoriteDrink(drinkId);
    return isFavorite != null;
  }

  Future<List<DrinkModel>> getAllFavoriteDrinks() async {
    final box = await favoriteBoxCompleter.future;
    final favorites = box.values.toList().cast<DrinkModel>();
    return favorites;
  }

  Future removeAllFavoriteDrinks() async {
    final box = await favoriteBoxCompleter.future;
    await box.clear();
  }

}
