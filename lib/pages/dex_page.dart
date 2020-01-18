import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';
import 'package:pixelmon_space/api/pokemon_api.dart';

import 'package:http/http.dart' as http;
import 'package:pixelmon_space/pokedex_list_entry.dart';
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
        padding: EdgeInsets.only(bottom: 20),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2, crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                  "/dex_info", arguments: pokemons[index]);
            },
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 16,
                      left: (index % 2 == 1) ? 5 : 0,
                      right: (index % 2 == 0) ? 5 : 0),
                  child: PokedexListEntry(pokemons[index]),
                ),
                Positioned(
                  left: (index % 2 == 1) ? 5 : 0,
                  top: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 5, top: 2, bottom: 2, right: 5),
                      color: Color(0xffFF7D7D),
                      child: Text(
                        "#${pokemons[index].id}",
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
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
