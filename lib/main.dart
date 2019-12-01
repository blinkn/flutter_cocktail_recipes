import 'package:cocktail_recipes/src/router.dart';
import 'package:cocktail_recipes/src/shared/controllers/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'src/shared/services/local_store.dart';

void main() async {
  GetIt.instance.registerLazySingleton(() => LocalStore());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoriteController>.value(value: FavoriteController())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cocktail Recipes',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: Router.getRoutes(context),
      ),
    );
  }
}
