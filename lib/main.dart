import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:whats_cooking/core/provider/favorite_provider.dart';
import 'package:whats_cooking/core/provider/recipe_provider.dart';
import 'package:whats_cooking/core/provider/search_provider.dart';
import 'package:whats_cooking/core/provider/user_provider.dart';
import 'package:whats_cooking/core/utils/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      textPadding: EdgeInsets.all(8),
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: Router.generateRoute,
          initialRoute: RouteName.signIn,
        ),
      ),
    );
  }
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => RecipeProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProxyProvider<UserProvider, SearchProvider>(
    create: (_) => SearchProvider(null),
    update: (context, userProv, searchProv) => SearchProvider(userProv.currentUser),
  ),
  ChangeNotifierProxyProvider<UserProvider, FavoriteProvider>(
    create: (_) => FavoriteProvider(null),
    update: (context, userProv, searchProv) => FavoriteProvider(userProv.currentUser),
  ),
];
