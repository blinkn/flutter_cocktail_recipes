import 'dart:math';

import 'package:cocktail_recipes/src/models/drink_model.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:cocktail_recipes/src/shared/widgets/badge.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  final DrinkModel drink;

  Header({@required this.drink});

  @override
  Widget build(BuildContext context) {
    Random r = Random();
    String stars = ((r.nextDouble() * 10) - 5).abs().toStringAsFixed(1);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 40.0,
          backgroundImage: Image.network(
            '${drink.drinkImageUrl}',
            fit: BoxFit.cover,
          ).image,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Txt(
                '${drink.drinkName}',
                style: titleStyle.clone()..textColor(Colors.white),
              ),
              Txt(
                '${drink.drinkCategory}',
                style: normalStyle.clone()
                  ..textColor(
                    Colors.white.withOpacity(.8),
                  )
                  ..textAlign.start(),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Badge(
              color: Colors.blue.shade900,
              child: Txt(
                '${drink.drinkType}',
                style: TxtStyle()..textColor(Colors.white),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Row(
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
                    style: normalStyle.clone()..textColor(Colors.white),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
