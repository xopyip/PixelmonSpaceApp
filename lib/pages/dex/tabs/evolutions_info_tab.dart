import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';

import '../../../constants.dart';

class EvolutionsInfoTab extends StatelessWidget {
  final Pokemon pokemon;

  EvolutionsInfoTab(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: pokemon.prevEvolutions
            .map((evolution) => EvolutionBox(evolution, false))
            .toList()
              ..addAll(pokemon.evolutions
                  .sublist(0, pokemon.evolutions.length > 0 ? 1 : 0)
                  .map((evolution) => EvolutionBox(evolution, true))
                  .toList())
              ..addAll(pokemon.nextEvolutions
                  .map((evolution) => EvolutionBox(evolution, false))
                  .toList()),
      ),
    );
  }
}

class EvolutionBox extends StatelessWidget {
  final bool current;
  final PokeEvolution evolution;

  EvolutionBox(this.evolution, this.current);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: current
            ? BoxDecoration(
                color: Color(0xffeeeeee),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      blurRadius: 4)
                ],
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PokeEvoInfo(evolution.fromID, evolution.from),
              Icon(Icons.arrow_right),
              Column(
                children: <Widget>[
                  Text("Wymagania:"),
                  buildEvoRequirement(evolution),
                ],
              ),
              Icon(Icons.arrow_right),
              PokeEvoInfo(evolution.toID, evolution.name),
            ],
          ),
        ),
      ),
    );
  }

  buildEvoRequirement(PokeEvolution evolution) {
    //return Text(evolution.evoType);
    switch (evolution.evoType) {
      case "leveling":
        return Text("Level: ${evolution.level}");
      case "trade":
        return Text("Wymiana");
      case "interact":
        return Text("Interakcja"); //TODO: add item/block
      //TODO: add rest types
    }
    return Container();
  }
}

class PokeEvoInfo extends StatelessWidget {
  final int toID;
  final String name;

  PokeEvoInfo(this.toID, this.name);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).popAndPushNamed("/dex_info", arguments: toID);
      },
      child: Column(
        children: <Widget>[
          CachedNetworkImage(
            fadeOutDuration: Duration(microseconds: 0),
            imageUrl:
                API_URL + "pokemon/sprite/${toID.toString().padLeft(3, '0')}",
            placeholder: (context, url) => Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, provider) => Image(
              image: provider,
              fit: BoxFit.contain,
              width: 100,
              height: 100,
              filterQuality: FilterQuality.none,
            ),
          ),
          Text(name)
        ],
      ),
    );
  }
}
