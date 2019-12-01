import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/shared/controllers/favorite_controller.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:cocktail_recipes/src/shared/widgets/badge.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DetailsCard extends StatefulWidget {

  final DrinkModel drink;

  DetailsCard({@required this.drink});

  @override
  _DetailsCardState createState() => _DetailsCardState(drink: drink);
}

class _DetailsCardState extends State<DetailsCard> {

  DrinkModel drink;
  bool isFavorite = false;

  _DetailsCardState({@required this.drink});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildShareLikeBar(),
            _buildIngredientsSection(),
            _buildInstructionsSection(),
            _buildGlassSection(),
            _buildTagsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildShareLikeBar() {
    return Padding(
      padding: EdgeInsets.only(right: 8.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          IconButton(
            onPressed: _handleShare,
            icon: Icon(Icons.share),
          ),
          Consumer<FavoriteController>(
            builder: (context, controller, wiget) {
              bool isFavorite = controller.favoriteDrinkList.where((d) => d.drinkId == drink.drinkId).length > 0;
              return IconButton(
                onPressed: () {
                  if (!isFavorite) {
                    controller.addFavoriteDrink(drink);
                  } else {
                    controller.removeFavoriteDrink(drink);
                  }
                },
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                color: isFavorite ? Colors.red : Colors.black,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsSection() {

    List<Widget> ingredientWidgets = [];

    for (int i = 0; i < drink.drinkIngredients.length; i++) {
      String measure = '';
      if (drink.drinkMeasures.length > i) {
        measure = drink.drinkMeasures[i];
      } else {
        measure = 'To taste';
      }
      ingredientWidgets.add(Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Txt(
          '- $measure ${drink.drinkIngredients[i]}',
          style: normalStyle.clone()..textAlign.start(),
        ),
      ));
    }

    return Transform.translate(
      offset: Offset(0, -52),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Txt(
              'INGREDIENTS',
              style: subtitleStyle,
            ),
            SizedBox(
              height: 20,
            )
          ]..addAll(ingredientWidgets),
        ),
      ),
    );
  }

  Widget _buildInstructionsSection() {
    return Transform.translate(
      offset: Offset(0, -52),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Txt(
              'INSTRUCTIONS',
              style: subtitleStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16.0),
              child: Txt(
                drink.drinkInstructions,
                style: normalStyle.clone()..textAlign.justify(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGlassSection() {
    return Transform.translate(
      offset: Offset(0, -52),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Txt(
              'GLASS',
              style: subtitleStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16.0),
              child: Txt(
                drink.drinkGlass,
                style: normalStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTagsSection() {
    if (drink.drinkTags.length <= 0) return Container();

    List<Widget> tagWidgets = drink.drinkTags
        .map((tag) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Badge(
                color: Colors.blue.shade900,
                child: Txt(
                  tag,
                  style: normalStyle.clone()..textColor(Colors.white),
                ),
              ),
            ))
        .toList();

    return Transform.translate(
      offset: Offset(0, -52),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Txt(
              'TAGS',
              style: subtitleStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: tagWidgets),
          ],
        ),
      ),
    );
  }

  void _handleShare() {
    String shareContent = '*${drink.drinkName}*\n\n';

    shareContent += 'INGREDIENTS\n';

    for (int i = 0; i < drink.drinkIngredients.length; i++) {
      String measure = '';
      if (drink.drinkMeasures.length > i) {
        measure = drink.drinkMeasures[i];
      } else {
        measure = 'To taste';
      }
      shareContent += '- $measure ${drink.drinkIngredients[i]}\n';
    }
    shareContent += '\n';

    shareContent += 'INSTRUCTIONS\n';
    shareContent += '${drink.drinkIngredients} \n';
    String shareSubject = 'Recipe: ${drink.drinkInstructions}';

    Share.share(shareContent, subject: shareSubject);
  }


  @override
  void dispose() {
    super.dispose();
  }
}
