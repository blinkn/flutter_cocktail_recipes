import 'package:cocktail_recipes/src/pages/home_page/widgets/category_section.dart';
import 'package:cocktail_recipes/src/pages/home_page/widgets/header.dart';
import 'package:cocktail_recipes/src/pages/home_page/widgets/ingredient_section.dart';
import 'package:cocktail_recipes/src/pages/home_page/widgets/option_section.dart';
import 'package:cocktail_recipes/src/shared/services/local_store.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'widgets/favorite_section.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blueGrey,
              height: 100,
            ),
            FlatButton(
              onPressed: () {
                GetIt.instance.get<LocalStore>().removeAllFavoriteDrinks();
              },
              child: Text('Clear Favorites'),
            )
          ],
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Header(),
          SizedBox(
            height: 10,
          ),
          FavoriteSection(),
          SizedBox(
            height: 10,
          ),
          CategorySection(),
          SizedBox(
            height: 10,
          ),
          Divider(),
          IngredientSection(),
          SizedBox(
            height: 10,
          ),
          Divider(),
          OptionSection(),
          SizedBox(
            height: 40,
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.elliptical(50, 40),
        topLeft: Radius.elliptical(50, 40),
      ),
      child: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: <Widget>[
              Txt(
                'Sample Cocktail Recipes App ${DateTime.now().year}',
                style: normalStyle.clone()
                  ..textColor(Colors.white)
                  ..textAlign.center(),
              ),
              Txt(
                'This is a flutter framework learning project',
                style: normalStyle.clone()
                  ..textColor(Colors.white)
                  ..textAlign.center(),
              ),
              Txt(
                'Data comes from The Cocktail DB (https://www.thecocktaildb.com/)',
                style: normalStyle.clone()
                  ..textColor(Colors.white)
                  ..textAlign.center(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
