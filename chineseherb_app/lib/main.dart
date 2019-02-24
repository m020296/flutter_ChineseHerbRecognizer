import 'package:flutter/material.dart';
import './pages/HomePage.dart';

import './pages/SingleHerb.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
      routes: {
        '/singleherb': (context) => SingleHerb(),
      },
    );
  }
}
