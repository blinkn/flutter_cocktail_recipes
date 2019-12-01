import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/shared/services/cocktail_api/cocktail_api.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class DrinksByOptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String option = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildHeader(context, option),
          _buildList(option),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String option) {
    return SliverAppBar(
      expandedHeight: 250,
      backgroundColor: Colors.blue,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          option,
          style: TextStyle(shadows: [Shadow(blurRadius: 20, offset: Offset.zero)]),
        ),
        background: Hero(
          tag: option,
          child: Image.asset(
            'assets/images/${option.replaceAll(RegExp('/| '), '')}.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildList(String category) {
    return FutureBuilder(
      future: CocktailAPI.fetchDrinksByOption(category),
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
