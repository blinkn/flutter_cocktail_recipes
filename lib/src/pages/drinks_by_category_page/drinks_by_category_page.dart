import 'dart:math';

import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/shared/services/cocktail_api/cocktail_api.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class DrinksByCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildHeader(context, category),
          _buildList(category),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String category) {
    return SliverAppBar(
      expandedHeight: 250,
      backgroundColor: Colors.blue,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          category,
          style: TextStyle(shadows: [Shadow(blurRadius: 20, offset: Offset.zero)]),
        ),
        background: Hero(
          tag: category,
          child: Image.asset(
            'assets/images/${category.replaceAll(RegExp('/| '), '')}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildList(String category) {
    return FutureBuilder(
      future: CocktailAPI.fetchDrinksByCategory(category),
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
              Random r = Random();
              String stars = ((r.nextDouble() * 10) - 5).abs().toStringAsFixed(1);

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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Txt(
                          '$stars',
                          style: normalStyle.clone(),
                        )
                      ],
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
