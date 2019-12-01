import 'package:align_positioned/align_positioned.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 265,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: RadialGradient(radius: 1, colors: [Colors.lightBlueAccent, Colors.blue]),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.elliptical(50, 40),
          bottomLeft: Radius.elliptical(50, 40),
        ),
      ),
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              height: 80,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  AlignPositioned(
                    dx: 75,
                    dy: -5,
                    child: Image.asset('assets/images/wine.png'),
                  ),
                  AlignPositioned(
                    dx: -35,
                    dy: -15,
                    child: Txt(
                      'Cocktail',
                      style: TxtStyle()
                        ..fontSize(40)
                        ..fontFamily('Lobster')
                        ..textColor(Colors.white),
                    ),
                  ),
                  AlignPositioned(
                    dx: 10,
                    dy: 15,
                    child: Txt(
                      'Recipes',
                      style: TxtStyle()
                        ..fontFamily('Lobster')
                        ..fontSize(30)
                        ..textColor(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 300,
                child: TextField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    setState(() {
                      search = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2),
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          if (search.length > 0) {
                            Navigator.pushNamed(context, '/search-result-page', arguments: search);
                          }
                        },
                        child: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () {
                if (search.length > 0) {
                  Navigator.pushNamed(context, '/search-result-page', arguments: search);
                }
              },
              textColor: Colors.white,
              child: Text('SEARCH'),
            )
          ],
        ),
      ),
    );
  }
}
