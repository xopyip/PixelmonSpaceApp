import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';
import 'package:pixelmon_space/api/pokemon_api.dart';
import 'package:http/http.dart' as http;
import 'package:pixelmon_space/utils.dart';

import '../constants.dart';
import '../controls.dart';

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

class BasicPokemonInfoTab extends StatelessWidget {
  final Pokemon pokemon;

  BasicPokemonInfoTab(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${100 - pokemon.malePercent}%",
                style: TextStyle(fontSize: 25)),
            Image(image: AssetImage("assets/female.png"), height: 40),
            Image(image: AssetImage("assets/male.png"), height: 40),
            Text("${pokemon.malePercent}%", style: TextStyle(fontSize: 25)),
          ],
        ),
        Column(
          children: <Widget>[
            Text("Typy:", style: TextStyle(fontSize: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.types
                  .map(
                    (type) =>
                    Badge(
                        backgroundColor: typesColors[type],
                        textColor: getBestContrast(
                            typesColors[type], Colors.white, Colors.black),
                        text: type),
              )
                  .toList(),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text("Abilitki:", style: TextStyle(fontSize: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.abilities.sublist(0, 2).where((
                  ability) => ability != null)
                  .map(
                    (ability) =>
                    Badge(
                        backgroundColor: Color(0xffeeeeee),
                        textColor: Colors.black,
                        text: ability),
              )
                  .toList(),
            ),
          ],
        ),
        pokemon.abilities.length > 2 && pokemon.abilities[2] != null ? Column(
          children: <Widget>[
            Text("Hidden Ability:", style: TextStyle(fontSize: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.abilities.sublist(2, 3).where((
                  ability) => ability != null)
                  .map(
                    (ability) =>
                    Badge(
                        backgroundColor: Color(0xffeeeeee),
                        textColor: Colors.black,
                        text: ability),
              )
                  .toList(),
            ),
          ],
        ) : Container(),
        Column(
          children: <Widget>[
            Text("Grupy jajeczkowe:", style: TextStyle(fontSize: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.eggGroups
                  .map(
                    (ability) =>
                    Badge(
                        backgroundColor: Color(0xffeeeeee),
                        textColor: Colors.black,
                        text: ability),
              )
                  .toList(),
            ),
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Image(image: AssetImage("assets/ride.png"), height: 30,),
                    Image(
                      image: AssetImage(pokemon.isRideable
                          ? "assets/tick.png"
                          : "assets/cross.png"), height: 30,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Image(image: AssetImage("assets/swim.png"), height: 30,),
                    Image(
                      image: AssetImage(pokemon.canSurf
                          ? "assets/tick.png"
                          : "assets/cross.png"), height: 30,),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Image(image: AssetImage("assets/fly.png"), height: 30,),
                    Image(image: AssetImage(pokemon.canFly
                        ? "assets/tick.png"
                        : "assets/cross.png"), height: 30,),
                  ],
                ),
              ),
            ]
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
