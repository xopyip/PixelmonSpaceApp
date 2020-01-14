import 'package:flutter/material.dart';
import 'package:pixelmon_space/pages/crafting_page.dart';
import 'package:pixelmon_space/pages/dex_page.dart';
import 'package:pixelmon_space/pages/drop_page.dart';
import 'package:pixelmon_space/pages/spawning_page.dart';

import 'navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Map<String, Widget Function(BuildContext)> routes = {
    "/dex": (context) => DexPage(),
    "/drop": (context) => DropPage(),
    "/spawning": (context) => SpawningPage(),
    "/crafting": (context) => CraftingPage(),
  };

  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixelmon Space',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Navigator(
            key: navigationKey,
            initialRoute: '/dex',
            onGenerateRoute: (settings) {
              var builder = routes[settings.name];
              if (builder == null) {
                return MaterialPageRoute(
                    settings: settings, builder: (_) => Container());
              }
              return MaterialPageRoute(
                  settings: settings, builder: (_) {
                return builder(context);
              });
            },
          ),
          bottomNavigationBar: Navigation(navigationKey)
      ),
    );
  }
}