import 'package:cocktail_recipes/src/shared/services/cocktail_api/models/drinks_model.dart';
import 'package:hive/hive.dart';

part 'drink_model.g.dart';

@HiveType()
class DrinkModel {
  @HiveField(0)
  String drinkId;

  @HiveField(1)
  String drinkName;

  @HiveField(2)
  String drinkImageUrl;

  @HiveField(3)
  String drinkInstructions;

  @HiveField(4)
  String drinkGlass;

  @HiveField(5)
  String drinkType;

  @HiveField(6)
  String drinkCategory;

  @HiveField(7)
  List<String> drinkIngredients;

  @HiveField(8)
  List<String> drinkMeasures;

  @HiveField(9)
  List<String> drinkTags;

  DrinkModel(
      {this.drinkId,
      this.drinkName,
      this.drinkImageUrl,
      this.drinkInstructions,
      this.drinkGlass,
      this.drinkType,
      this.drinkCategory,
      this.drinkIngredients,
      this.drinkMeasures,
      this.drinkTags});

  DrinkModel.fromJson(Map<String, dynamic> json) {
    drinkId = json['drinkId'];
    drinkName = json['drinkName'];
    drinkImageUrl = json['drinkImageUrl'];
    drinkInstructions = json['drinkInstructions'];
    drinkGlass = json['drinkGlass'];
    drinkType = json['drinkType'];
    drinkCategory = json['drinkCategory'];
    drinkIngredients = json['drinkIngredients'].cast<String>();
    drinkMeasures = json['drinkMeasures'].cast<String>();
    drinkTags = json['drinkTags'].cast<String>();
  }

  DrinkModel.fromCocktailApiDrinkModel(CocktailApiDrink drink) {
    drinkId = drink.idDrink;
    drinkName = drink.strDrink;
    drinkImageUrl = drink.strDrinkThumb;
    drinkInstructions = drink.strInstructions;
    drinkGlass = drink.strGlass;
    drinkType = drink.strAlcoholic;
    drinkCategory = drink.strCategory;

    drinkIngredients = List<String>();
    drinkIngredients.addAll([
      drink.strIngredient1,
      drink.strIngredient2,
      drink.strIngredient3,
      drink.strIngredient4,
      drink.strIngredient5,
      drink.strIngredient6,
      drink.strIngredient7,
      drink.strIngredient8,
      drink.strIngredient9,
      drink.strIngredient10,
      drink.strIngredient11,
      drink.strIngredient12,
      drink.strIngredient13,
      drink.strIngredient14,
      drink.strIngredient15
    ]);
    drinkIngredients.removeWhere((ingredient) => ingredient == null);

    drinkMeasures = List<String>();
    drinkMeasures.addAll([
      drink.strMeasure1,
      drink.strMeasure2,
      drink.strMeasure3,
      drink.strMeasure4,
      drink.strMeasure5,
      drink.strMeasure6,
      drink.strMeasure7,
      drink.strMeasure8,
      drink.strMeasure9,
      drink.strMeasure10,
      drink.strMeasure11,
      drink.strMeasure12,
      drink.strMeasure13,
      drink.strMeasure14,
      drink.strMeasure15
    ]);
    drinkMeasures.removeWhere((measure) => measure == null);

    drinkTags = drink.strTags == null
        ? List<String>()
        : drink.strTags.split(',').map((tag) => tag.trim()).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drinkId'] = this.drinkId;
    data['drinkName'] = this.drinkName;
    data['drinkImageUrl'] = this.drinkImageUrl;
    data['drinkInstructions'] = this.drinkInstructions;
    data['drinkGlass'] = this.drinkGlass;
    data['drinkType'] = this.drinkType;
    data['drinkCategory'] = this.drinkCategory;
    data['drinkIngredients'] = this.drinkIngredients;
    data['drinkMeasures'] = this.drinkMeasures;
    data['drinkTags'] = this.drinkTags;
    return data;
  }
}
