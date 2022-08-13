import 'package:app/models/services.dart';

import 'package:app/screens/home.dart';
import 'package:app/screens/login.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => ServiceModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        // ChangeNotifierProxyProvider<CatalogModel, CartModel>(
        //   create: (context) => CartModel(),
        //   update: (context, catalog, cart) {
        //     if (cart == null) throw ArgumentError.notNull('cart');
        //     cart.catalog = catalog;
        //     return cart;
        //   },
        // ),
      ],
      child: MaterialApp(
        title: 'Puppy Spa',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/home': (context) => const Home(),
        },
      ),
    );
  }
}
