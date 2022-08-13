import 'package:app/components/calendar.dart';
import 'package:app/components/waitlist.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  final String appTitle = "🐶 Puppy Spa";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(appTitle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
          // centerTitle: false,
          // backgroundColor: Colors.redAccent[200],
        ),
        // backgroundColor: const Color(0xFF333A47),
        body: Column(
          children: const [
            Calendar(),
            Expanded(
              child: ListPad(),
            ),
          ],
        ),
      ),
    );
  }
}
