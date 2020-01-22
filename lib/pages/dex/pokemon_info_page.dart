import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';
import 'package:pixelmon_space/api/pokemon_api.dart';
import 'package:pixelmon_space/pages/dex/stats_graph.dart';
import 'package:pixelmon_space/pages/dex/tabs/basic_pokemon_info_tab.dart';
import 'package:pixelmon_space/pages/dex/tabs/evolutions_info_tab.dart';
import 'package:pixelmon_space/pages/dex/tabs/moves_info_tab.dart';

import '../../constants.dart';

class PokemonInfoPage extends StatefulWidget {
  final int id;

  PokemonInfoPage(this.id);

  @override
  _PokemonInfoPageState createState() => _PokemonInfoPageState(this.id);
}

class _PokemonInfoPageState extends State<PokemonInfoPage>
    with TickerProviderStateMixin {
  int id;
  Pokemon pokemon;

  _PokemonInfoPageState(this.id);

  @override
  void initState() {
    setState(() {
      pokemon = null;
    });
    loadPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffffffff),
        child: Stack(
          children: <Widget>[
            //top background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 120,
                    child: Container(
                      color: Color(0xffff7d7d),
                    ),
                  ),
                  Image(
                    image: AssetImage("assets/info_bg.png"),
                  ),
                ],
              ),
            ),
            //bottom background
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image(
                image: AssetImage("assets/bottom_bg.png"),
              ),
            ),
            //Content
            Positioned(
              top: 160,
              left: 0,
              right: 0,
              bottom: 0,
              child: pokemon == null
                  ? Container() : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: StatsGraph(pokemon.stats),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: DefaultTabController(
                        length: 3,
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          appBar: TabBar(
                            unselectedLabelColor: Colors.black26,
                            labelColor: Colors.redAccent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: Colors.redAccent,
                            indicatorWeight: 6,
                            tabs: [
                              Tab(
                                child: Text(
                                  "Informacje podstawowe",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Ewolucje",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Ataki",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          body: TabBarView(
                            children: [
                              BasicPokemonInfoTab(this.pokemon),
                              EvolutionsInfoTab(this.pokemon),
                              MovesInfoTab(this.pokemon),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Top pokeball
            Positioned(
              top: -30,
              right: -40,
              child: SizedBox(
                height: 200,
                child: Image(image: AssetImage("assets/pokeball.png")),
              ),
            ),
            //back button and title
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              top: 55,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Color(0xffffffff),
                        ),
                      )),
                  pokemon == null
                      ? SizedBox(
                      width: 30, height: 30, child: CircularProgressIndicator())
                      : Text(
                    this.pokemon.pixelmonName,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffffffff)),
                  ),
                ],
              ),
            ),
            //pokemon icon
            Positioned(
              top: 140,
              right: 5,
              child: Container(
                child: CachedNetworkImage(
                  width: 150,
                  height: 150,
                  fadeOutDuration: Duration(microseconds: 0),
                  imageUrl: API_URL +
                      "pokemon/sprite/${this.id.toString()
                          .padLeft(3, '0')}",
                  placeholder: (context, url) =>
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: SizedBox(width: 30,
                              height: 30,
                              child: CircularProgressIndicator()),
                        ),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageBuilder: (context, provider) =>
                      Image(
                        image: provider,
                        fit: BoxFit.contain,
                        width: 150,
                        height: 150,
                        filterQuality: FilterQuality.none,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadPokemon() async {
    Pokemon pokemon = await fetchPokemon(id);
    setState(() {
      this.pokemon = pokemon;
    });
  }
}




