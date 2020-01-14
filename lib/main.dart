
import 'package:flutter/material.dart';
import 'package:pixelmon_space/dex_page.dart';

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
      initialRoute: "/dex",
      routes: {
        "/dex": (context) => DexPage()
      },
    );
  }
}