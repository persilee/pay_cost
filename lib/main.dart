import 'package:flutter/material.dart';

import 'navigator/tab_navigater.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '工易付缴费',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 180, 184, 1),
        highlightColor: Color.fromRGBO(255, 255, 255, 0.6),
        splashColor: Color.fromRGBO(0, 180, 184, 0.5),
      ),
      home: TabNavigator(),
    );
  }
}


