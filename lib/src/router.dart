import 'pages/categories_list_page/categories_list_page.dart';
import 'pages/drink_details_page/drink_details_page.dart';
import 'pages/drinks_by_category_page/drinks_by_category_page.dart';
import 'pages/drinks_by_ingredient_page/drinks_by_ingredient_page.dart';
import 'pages/drinks_by_option_page/drinks_by_option_page.dart';
import 'pages/home_page/home_page.dart';
import 'pages/ingredients_list_page/ingredients_list_page.dart';
import 'pages/search_result_page/search_result_page.dart';

class Router {

  static getRoutes(context) {
    return {
      '/': (context) => HomePage(),
      '/home': (context) => HomePage(),
      '/search-result-page': (context) => SearchResultPage(),
      '/drink-details': (context) => DrinkDetailsPage(),
      '/category-list': (context) => CategoriesListPage(),
      '/ingredient-list': (context) => IngredientsListPage(),
      '/drinks-by-category': (context) => DrinksByCategoryPage(),
      '/drinks-by-ingredient': (context) => DrinksByIngredientPage(),
      '/drinks-by-option': (context) => DrinksByOptionPage(),
    };
  }

}
