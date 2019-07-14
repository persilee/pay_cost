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
        primarySwatch: Colors.blue,
        highlightColor: Color.fromRGBO(255, 255, 255, 0.6),
        splashColor: Colors.blue[100],
      ),
      home: TabNavigator(),
    );
  }
}


