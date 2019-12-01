import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/shared/controllers/favorite_controller.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteSection extends StatefulWidget {
  @override
  _FavoriteSectionState createState() => _FavoriteSectionState();
}

class _FavoriteSectionState extends State<FavoriteSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteController>(
      builder: (context, controller, widget) {

        if(controller.favoriteDrinkList.length == 0) {
          return Container();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Txt(
                'Your Favorites',
                style: subtitleStyle.clone()..textColor(Colors.blueGrey),
              ),
            ),
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.favoriteDrinkList.length,
                itemBuilder: (context, index) {
                  DrinkModel drink = controller.favoriteDrinkList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/drink-details', arguments: drink.drinkId);
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(drink.drinkImageUrl),
                            radius: 40,
                          ),
                        ),
                        Txt(
                          '${drink.drinkName.length > 13 ? drink.drinkName.substring(0, 10) + '...' : drink.drinkName}',
                          style: normalStyle.clone()..textColor(Colors.blueGrey),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
