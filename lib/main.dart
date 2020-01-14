import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pixelmon_space/navigation.dart';
import 'package:pixelmon_space/page_template.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixelmon Space',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: "PokeDex",
      child: Container(
        child: Text("Test"),
      )
    );
  }
}
