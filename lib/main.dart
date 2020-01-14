
import 'package:flutter/material.dart';
import 'package:pixelmon_space/pages/crafting_page.dart';
import 'package:pixelmon_space/pages/dex_page.dart';
import 'package:pixelmon_space/pages/drop_page.dart';
import 'package:pixelmon_space/page_transitions.dart';
import 'package:pixelmon_space/pages/spawning_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixelmon Space',
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: NoTransitionPage(),
          TargetPlatform.android: NoTransitionPage(),
        }),
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/dex",
      routes: {
        "/dex": (context) => DexPage(),
        "/drop": (context) => DropPage(),
        "/spawning": (context) => SpawningPage(),
        "/crafting": (context) => CraftingPage(),
      },
    );
  }
}