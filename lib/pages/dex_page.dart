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
      child: GridView.builder(
        itemCount: pokemons.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: <Widget>[
                Text("#${pokemons[index].id}"),
                Text("Pokemon ${pokemons[index].pixelmonName}"),
                Text("Typy ${pokemons[index].types}"),
                Text("HP ${pokemons[index].stats.hp}"),
                Text("atk ${pokemons[index].stats.attack}"),
                Text("def ${pokemons[index].stats.defence}"),
                Text("spatk ${pokemons[index].stats.specialAttack}"),
                Text("spdef ${pokemons[index].stats.specialDefence}"),
                Text("spd ${pokemons[index].stats.speed}"),
              ],
            ),
          );
        },
      ),
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
