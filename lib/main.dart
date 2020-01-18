import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';
import 'package:pixelmon_space/pages/crafting_page.dart';
import 'package:pixelmon_space/pages/dex_page.dart';
import 'package:pixelmon_space/pages/drop_page.dart';
import 'package:pixelmon_space/pages/pokemon_info_page.dart';
import 'package:pixelmon_space/pages/spawning_page.dart';

import 'navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    "/dex": (context, settings) => DexPage(navigationKey),
    "/drop": (context, settings) => DropPage(),
    "/spawning": (context, settings) => SpawningPage(),
    "/crafting": (context, settings) => CraftingPage(),
    "/dex_info": (context, settings) =>
        PokemonInfoPage(settings.arguments as PokemonListEntry, navigationKey),
  };

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
                return builder(context, settings);
              });
            },
          ),
          bottomNavigationBar: Navigation(navigationKey)
      ),
    );
  }
}