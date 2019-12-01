import 'package:cocktail_recipes/src/data/ingredients.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class IngredientSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Txt(
                'Ingredients',
                style: subtitleStyle.clone()..textColor(Colors.blueGrey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/ingredient-list');
                },
                child: Txt(
                  'See all',
                  style: normalStyle.clone()..textColor(Colors.blue),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 235,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 15,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/drinks-by-ingredient', arguments: ingredients[index]);
                },
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: ingredients[index],
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          //color: Colors.deepPurple,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://www.thecocktaildb.com/images/ingredients/${ingredients[index]}-Medium.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 140,
                        height: 200,
                      ),
                    ),
                    Text(
                      ingredients[index],
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
