import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';

import '../../../constants.dart';
import '../../../controls.dart';
import '../../../utils.dart';

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
                    (type) => Badge(
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
              children: pokemon.abilities
                  .sublist(0, 2)
                  .where((ability) => ability != null)
                  .map(
                    (ability) => Badge(
                        backgroundColor: Color(0xffeeeeee),
                        textColor: Colors.black,
                        text: ability),
                  )
                  .toList(),
            ),
          ],
        ),
        pokemon.abilities.length > 2 && pokemon.abilities[2] != null
            ? Column(
                children: <Widget>[
                  Text("Hidden Ability:", style: TextStyle(fontSize: 25)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pokemon.abilities
                        .sublist(2, 3)
                        .where((ability) => ability != null)
                        .map(
                          (ability) => Badge(
                              backgroundColor: Color(0xffeeeeee),
                              textColor: Colors.black,
                              text: ability),
                        )
                        .toList(),
                  ),
                ],
              )
            : Container(),
        Column(
          children: <Widget>[
            Text("Grupy jajeczkowe:", style: TextStyle(fontSize: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pokemon.eggGroups
                  .map(
                    (ability) => Badge(
                        backgroundColor: Color(0xffeeeeee),
                        textColor: Colors.black,
                        text: ability),
                  )
                  .toList(),
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage("assets/ride.png"),
                  height: 30,
                ),
                Image(
                  image: AssetImage(pokemon.isRideable
                      ? "assets/tick.png"
                      : "assets/cross.png"),
                  height: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage("assets/swim.png"),
                  height: 30,
                ),
                Image(
                  image: AssetImage(
                      pokemon.canSurf ? "assets/tick.png" : "assets/cross.png"),
                  height: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage("assets/fly.png"),
                  height: 30,
                ),
                Image(
                  image: AssetImage(
                      pokemon.canFly ? "assets/tick.png" : "assets/cross.png"),
                  height: 30,
                ),
              ],
            ),
          ),
        ]),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
