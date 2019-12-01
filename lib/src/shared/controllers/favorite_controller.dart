import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/shared/services/local_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class FavoriteController extends ChangeNotifier {

  LocalStore localStore;
  List<DrinkModel> favoriteDrinkList = List<DrinkModel>();

  FavoriteController() {
    localStore = GetIt.instance.get<LocalStore>();
    _initData();
  }

  _initData() async {
    List<DrinkModel> list = await localStore.getAllFavoriteDrinks();
    favoriteDrinkList.addAll(list);
    notifyListeners();
  }

  void addFavoriteDrink(DrinkModel drinkModel) {
    localStore.addFavoriteDrink(drinkModel);
    favoriteDrinkList.add(drinkModel);
    notifyListeners();
  }

  void removeFavoriteDrink(DrinkModel drinkModel) {
    localStore.removeFavoriteDrink(drinkModel.drinkId);
    favoriteDrinkList.removeWhere((d) => d.drinkId == drinkModel.drinkId);
    notifyListeners();
  }

}
