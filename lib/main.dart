import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';
import 'package:pixelmon_space/page_transitions.dart';
import 'package:pixelmon_space/pages/crafting_page.dart';
import 'package:pixelmon_space/pages/dex_page.dart';
import 'package:pixelmon_space/pages/drop_page.dart';
import 'package:pixelmon_space/pages/pokemon_info_page.dart';
import 'package:pixelmon_space/pages/spawning_page.dart';

import 'navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  Map<String, Widget Function(BuildContext, RouteSettings)> routes = {
    "/dex": (context, settings) => DexPage(),
    "/drop": (context, settings) => DropPage(),
    "/spawning": (context, settings) => SpawningPage(),
    "/crafting": (context, settings) => CraftingPage(),
    "/dex_info": (context, settings) =>
        PokemonInfoPage(settings.arguments as PokemonListEntry),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixelmon Space',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: NoTransitionPage(),
          TargetPlatform.android: NoTransitionPage(),
        }),
      ),
      debugShowCheckedModeBanner: false,
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
    );
  }
}