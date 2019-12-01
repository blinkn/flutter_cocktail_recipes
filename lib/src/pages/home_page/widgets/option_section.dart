import 'package:align_positioned/align_positioned.dart';
import 'package:cocktail_recipes/src/data/options.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class OptionSection extends StatelessWidget {
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
                'Options',
                style: subtitleStyle.clone()..textColor(Colors.blueGrey),
              )
            ],
          ),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/drinks-by-option', arguments: options[index]);
                },
                child: Hero(
                  tag: options[index],
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepOrange,
                      image: DecorationImage(
                          image: AssetImage('assets/images/${options[index].replaceAll(RegExp('/| '), '')}.png'),
                          fit: BoxFit.cover),
                    ),
                    width: 140,
                    child: AlignPositioned(
                      alignment: Alignment.bottomLeft,
                      childWidth: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Container(
                          height: 25,
                          color: Colors.black.withOpacity(.5),
                          child: AlignPositioned(
                            alignment: Alignment.centerLeft,
                            dx: 10,
                            child: Text(
                              options[index],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
