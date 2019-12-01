import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/shared/services/cocktail_api/cocktail_api.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String searchString = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search: $searchString'),
      ),
      body: FutureBuilder(
        future: CocktailAPI.searchDrinks(searchString),
        builder: (context, AsyncSnapshot<List<DrinkModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {}

          if (snapshot.data == null || snapshot.data.length <= 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.blueGrey,
                  ),
                  Txt(
                    'Could not find any drinks',
                    style: normalStyle.clone()..textColor(Colors.blueGrey),
                  ),
                  Txt(
                    'Please, try again',
                    style: normalStyle.clone()..textColor(Colors.blueGrey),
                  ),
                ],
              ),
            );
          }

          List<DrinkModel> drinksList = snapshot.data;

          return ListView.separated(
              itemCount: drinksList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: index == 0 ? 10 : 0,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/drink-details', arguments: drinksList[index].drinkId);
                      },
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(drinksList[index].drinkImageUrl),
                      ),
                      title: Txt(
                        drinksList[index].drinkName,
                        style: normalStyle,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
          );
        },
      ),
    );
  }
}
