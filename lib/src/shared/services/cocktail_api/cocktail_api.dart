import 'dart:convert';

import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/shared/services/cocktail_api/models/drinks_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CocktailAPI {

  static String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1';

  static Future<DrinkModel> fetchDrink(String drinkId) async {
    Response response = await http.get('$baseUrl/lookup.php?i=$drinkId');
    CocktailApiDrinks drinks = CocktailApiDrinks.fromJson(jsonDecode(response.body));

    // Get the first (and unique) drink
    CocktailApiDrink drink = drinks.drinks.first;

    // Convert Api model to App model
    DrinkModel drinkModel = DrinkModel.fromCocktailApiDrinkModel(drink);
    return Future.value(drinkModel);
  }

  static Future<DrinkModel> fetchRandomDrink() async {
    Response response = await http.get('$baseUrl/random.php');
    CocktailApiDrinks drinks = CocktailApiDrinks.fromJson(jsonDecode(response.body));

    // Get the first (and unique) drink
    CocktailApiDrink drink = drinks.drinks.first;

    // Convert Api model to App model
    DrinkModel drinkModel = DrinkModel.fromCocktailApiDrinkModel(drink);
    return Future.value(drinkModel);
  }

  static Future<List<DrinkModel>> fetchDrinksByCategory(String category) async {
    String _category = category.replaceAll(RegExp(' '), '_');
    Response response = await http.get('$baseUrl/filter.php?c=$_category');
    CocktailApiDrinks drinks = CocktailApiDrinks.fromJson(jsonDecode(response.body));

    // Convert Api model to App model
    List<DrinkModel> drinkModels = drinks.drinks.map((d) => DrinkModel.fromCocktailApiDrinkModel(d)).toList();
    return Future.value(drinkModels);
  }

  static Future<List<DrinkModel>> fetchDrinksByIngredient(String ingredient) async {
    Response response = await http.get('$baseUrl/filter.php?i=$ingredient');
    CocktailApiDrinks drinks = CocktailApiDrinks.fromJson(jsonDecode(response.body));

    // Convert Api model to App model
    List<DrinkModel> drinkModels = drinks.drinks.map((d) => DrinkModel.fromCocktailApiDrinkModel(d)).toList();
    return Future.value(drinkModels);
  }

  static Future<List<DrinkModel>> fetchDrinksByOption(String option) async {
    Response response = await http.get('$baseUrl/filter.php?a=$option');
    CocktailApiDrinks drinks = CocktailApiDrinks.fromJson(jsonDecode(response.body));

    // Convert Api model to App model
    List<DrinkModel> drinkModels = drinks.drinks.map((d) => DrinkModel.fromCocktailApiDrinkModel(d)).toList();
    return Future.value(drinkModels);
  }

  static Future<List<DrinkModel>> searchDrinks(String searchString) async {
    Response response = await http.get('$baseUrl/search.php?s=$searchString');
    CocktailApiDrinks drinks = CocktailApiDrinks.fromJson(jsonDecode(response.body));

    // Convert Api model to App model
    List<DrinkModel> drinkModels = drinks.drinks.map((d) => DrinkModel.fromCocktailApiDrinkModel(d)).toList();
    return Future.value(drinkModels);
  }


}
