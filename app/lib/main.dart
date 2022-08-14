import 'package:app/models/date.dart';
import 'package:app/models/services.dart';

import 'package:app/screens/home.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/search.dart';
import 'package:app/service/data/waitlists.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:provider/provider.dart';

import 'common/theme.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ServiceModel()),
        ChangeNotifierProvider(create: (context) => DateModel()),
        ChangeNotifierProvider(create: (context) => WaitlistsData())
      ],
      child: MaterialApp(
        title: 'Puppy Spa',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/home': (context) => const Home(),
          '/search': (context) => const Search(),
        },
      ),
    );
  }
}
