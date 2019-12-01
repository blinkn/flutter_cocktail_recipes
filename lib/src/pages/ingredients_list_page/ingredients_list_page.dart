import 'package:cocktail_recipes/src/data/ingredients.dart';
import 'package:cocktail_recipes/src/shared/theme/text.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class IngredientsListPage extends StatefulWidget {
  @override
  _IngredientsListPageState createState() => _IngredientsListPageState();
}

class _IngredientsListPageState extends State<IngredientsListPage> with SingleTickerProviderStateMixin {

  bool isSearchOpen = false;
  String search = '';
  FocusNode searchFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('Ingredients List'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearchOpen = !isSearchOpen;
                      if (isSearchOpen) {
                        FocusScope.of(context).requestFocus(searchFocusNode);
                      }
                    });
                  },
                )
              ],
            ),
            body: Column(
              children: <Widget>[
                _buildSearchBar(),
                Expanded(
                  child: _buildList(),
                ),
              ],
            ),
          );
  }

  _buildSearchBar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: isSearchOpen ? 68 : 0,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.5),
            borderRadius: BorderRadius.circular(6)
          ),
          child: TextField(
            focusNode: searchFocusNode,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
            ),
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildList() {

    List<String> _ingredients = getIngredients(search);

    return ListView.separated(
      itemCount: _ingredients.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        String ingredient = _ingredients[index];
        return _buildListItem(ingredient, index);
      },
    );
  }

  Widget _buildListItem(String ingredient, int index) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: index == 0 ? 8 : 0,
        ),
        ListTile(
          leading: Hero(
            tag: ingredient,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage:
              NetworkImage('https://www.thecocktaildb.com/images/ingredients/$ingredient-Small.png'),
              radius: 30,
            ),
          ),
          title: Txt(
            ingredient,
            style: normalStyle,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/drinks-by-ingredient', arguments: ingredient);
          },
        ),
      ],
    );
  }

  List<String> getIngredients(String search) {
    return ingredients.where((i) => search.length > 0 ? i.toLowerCase().contains(search.toLowerCase()) : true).toList();
  }

  @override
  void dispose() {
    super.dispose();
    searchFocusNode.dispose();
  }
}
