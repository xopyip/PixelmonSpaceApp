import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';
import 'package:pixelmon_space/api/pokemon_api.dart';

import 'package:http/http.dart' as http;
import '../page_template.dart';

class DexPage extends StatefulWidget {
  DexPage({Key key}) : super(key: key);

  @override
  _DexPageState createState() {
    return _DexPageState();
  }
}

class _DexPageState extends State<DexPage> {

  List<PokemonListEntry> pokemons;

  @override
  void initState() {
    setState(() {
      pokemons = [];
    });
    print("init state");
    loadPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: "PokeDex",
        child: Container(
          child: Text("Test"),
        )
    );
  }

  void loadPokemons() async {
    var p = await fetchPokemons(http.Client());
    print("loaded ${p.length} pokemons");
    setState(() {
      pokemons = p;
    });
  }
}