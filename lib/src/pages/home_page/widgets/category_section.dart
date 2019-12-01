import 'package:align_positioned/align_positioned.dart';
import 'package:cocktail_recipes/src/data/categories.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
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
                'Categories',
                style: subtitleStyle.clone()..textColor(Colors.blueGrey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/category-list');
                },
                child: Txt(
                  'See all',
                  style: normalStyle.clone()..textColor(Colors.blue),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/drinks-by-category', arguments: categories[index]);
                  },
                  child: Hero(
                    tag: categories[index],
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepOrange,
                        image: DecorationImage(
                            image: AssetImage('assets/images/${categories[index].replaceAll(RegExp('/| '), '')}.png'),
                            fit: BoxFit.cover),
                      ),
                      width: 140,
                      child: AlignPositioned(
                        alignment: Alignment.bottomLeft,
                        childWidth: 140,
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          child: Container(
                            height: 25,
                            color: Colors.black.withOpacity(.5),
                            child: AlignPositioned(
                              alignment: Alignment.centerLeft,
                              dx: 10,
                              child: Text(
                                categories[index],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
