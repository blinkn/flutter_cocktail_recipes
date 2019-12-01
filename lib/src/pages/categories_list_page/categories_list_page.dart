import 'package:cocktail_recipes/src/data/categories.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class CategoriesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category List'),
      ),
      body: Container(
        child: ListView.separated(
          itemCount: categories.length,
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: index == 0 ? 8 : 0,
                ),
                ListTile(
                  leading: Hero(
                    tag: categories[index],
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/${categories[index].replaceAll(RegExp('/| '), '')}.png'),
                      radius: 30,
                    ),
                  ),
                  title: Txt(
                    categories[index],
                    style: normalStyle,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/drinks-by-category', arguments: categories[index]);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
