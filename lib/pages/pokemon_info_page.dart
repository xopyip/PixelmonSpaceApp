import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';
import 'package:pixelmon_space/api/pokemon_api.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class PokemonInfoPage extends StatefulWidget {
  final PokemonListEntry pokemon;

  PokemonInfoPage(this.pokemon);

  @override
  _PokemonInfoPageState createState() => _PokemonInfoPageState(this.pokemon);
}

class _PokemonInfoPageState extends State<PokemonInfoPage>
    with TickerProviderStateMixin {
  PokemonListEntry pokemonListEntry;
  Pokemon pokemon;

  _PokemonInfoPageState(this.pokemonListEntry);

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
            //Content
            Positioned(
              top: 160,
              left: 0,
              right: 0,
              bottom: 0,
              child: pokemon == null
                  ? CircularProgressIndicator()
                  : Column(
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
                              Tab(child: Text("Informacje podstawowe",
                                textAlign: TextAlign.center,),),
                              Tab(child: Text(
                                "Ewolucje", textAlign: TextAlign.center,),),
                              Tab(child: Text(
                                "Ataki", textAlign: TextAlign.center,),),
                            ],
                          ),
                          body: TabBarView(
                            children: [
                              Container(
                                child: Text("informacje podstawowe"),
                              ),
                              Container(
                                child: Text("Ewolucje"),
                              ),
                              Container(
                                child: Text("Ataki"),
                              ),
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
                  Text(
                    this.pokemonListEntry.pixelmonName,
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
                      "pokemon/sprite/${this.pokemonListEntry.id.toString()
                          .padLeft(3, '0')}",
                  placeholder: (context, url) =>
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: CircularProgressIndicator(),
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
    Pokemon pokemon = await fetchPokemon(this.pokemonListEntry.id);
    setState(() {
      this.pokemon = pokemon;
    });
  }
}

class StatsGraph extends StatelessWidget {
  final PokeStats stats;

  StatsGraph(this.stats);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: Table(
          columnWidths: {
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
          },
          children: [
            TableRow(children: [
              Text("HP", textAlign: TextAlign.center),
              StatsBar(stats.hp, Color(0xff18CA33)),
            ]),
            TableRow(children: [
              Text("Atk", textAlign: TextAlign.center),
              StatsBar(stats.attack, Color(0xffF46263)),
            ]),
            TableRow(children: [
              Text("Def", textAlign: TextAlign.center),
              StatsBar(stats.defence, Color(0xffDA8525)),
            ]),
            TableRow(children: [
              Text("SpAtk", textAlign: TextAlign.center),
              StatsBar(stats.specialAttack, Color(0xffC338D3)),
            ]),
            TableRow(children: [
              Text("SpDef", textAlign: TextAlign.center),
              StatsBar(stats.specialDefence, Color(0xffD1A700)),
            ]),
            TableRow(children: [
              Text("Spd", textAlign: TextAlign.center),
              StatsBar(stats.speed, Color(0xff13CDEB)),
            ]),
          ],
        ),
      ),
    );
  }
}

class StatsBar extends StatelessWidget {
  final int stat;
  final Color color;
  static final max = 255;

  StatsBar(this.stat, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: Stack(
        children: <Widget>[
          Container(
            height: 16,
            color: Color(0x80000000 + (color.value & 0xffffff)),
          ),
          FractionallySizedBox(
            widthFactor: this.stat / max,
            child: Container(
              height: 16,
              color: color,
            ),
          ),
          Center(
            child: Text(
              "$stat",
              style: TextStyle(
                  color: this.stat < 0.4 * max
                      ? Color(0xff000000)
                      : Color(0xffffffff)),
            ),
          )
        ],
      ),
    );
  }
}
