import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/pages/drink_details_page/widgets/details_card.dart';
import 'package:cocktail_recipes/src/pages/drink_details_page/widgets/header.dart';
import 'package:cocktail_recipes/src/shared/services/cocktail_api/cocktail_api.dart';
import 'package:flutter/material.dart';

class DrinkDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String drinkId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Drink Details'),
      ),
      body: Stack(
        children: <Widget>[
          _buildBackground(),
          FutureBuilder(
            future: CocktailAPI.fetchDrink(drinkId),
            builder: (BuildContext context, AsyncSnapshot<DrinkModel> snapshot) {
              return _buildScreen(snapshot);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        gradient: RadialGradient(radius: 1, colors: [Colors.lightBlueAccent, Colors.blue]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 40),
          bottomRight: Radius.elliptical(50, 40),
        ),
      ),
    );
  }

  Widget _buildScreen(AsyncSnapshot<DrinkModel> snapshot) {
    if (!snapshot.hasData) {
      return Container(
        height: 300,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ),
      );
    }

    if (snapshot.hasError) {}

    DrinkModel drink = snapshot.data;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Header(drink: drink),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0, bottom: 16.0),
            child: DetailsCard(drink: drink),
          ),
        ),
      ],
    );
  }
}
