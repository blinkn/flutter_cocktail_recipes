import 'package:align_positioned/align_positioned.dart';
import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/shared/services/cocktail_api/cocktail_api.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class DrinksByIngredientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String ingredient = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildHeader(context, ingredient),
          _buildList(ingredient),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String ingredient) {
    return SliverAppBar(
      expandedHeight: 250,
      backgroundColor: Colors.blue,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          ingredient,
          style: TextStyle(shadows: [Shadow(blurRadius: 20, offset: Offset.zero)]),
        ),
        background: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1,
                colors: [Colors.lightBlueAccent, Colors.blue],
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          AlignPositioned(
            child: Hero(
              tag: ingredient,
              child: Image.network(
                'https://www.thecocktaildb.com/images/ingredients/$ingredient.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildList(String category) {
    return FutureBuilder(
      future: CocktailAPI.fetchDrinksByIngredient(category),
      builder: (context, AsyncSnapshot<List<DrinkModel>> snapshot) {
        if (!snapshot.hasData) {
          return SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {}

        List<DrinkModel> drinkList = snapshot.data;

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: index == 0 ? 10 : 0,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(drinkList[index].drinkImageUrl),
                      radius: 25,
                    ),
                    title: Txt(
                      drinkList[index].drinkName,
                      style: normalStyle,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/drink-details', arguments: drinkList[index].drinkId);
                    },
                  ),
                  Divider()
                ],
              );
            },
            childCount: drinkList.length,
          ),
        );
      },
    );
  }
}
