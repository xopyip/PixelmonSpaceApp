import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';
import 'package:pixelmon_space/constants.dart';
import 'package:pixelmon_space/utils.dart';

class PokedexListEntry extends StatelessWidget {
  final PokemonListEntry pokemon;

  PokedexListEntry(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffFF7D7D),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -22,
              right: -22,
              child: SizedBox(
                height: 80,
                child: Image(image: AssetImage("assets/pokeball.png")),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: StatsRow(pokemon),
            ),
            Positioned(
              top: -20,
              right: -20,
              child: SizedBox(
                height: 80,
                child: CachedNetworkImage(
                  fadeOutDuration: Duration(microseconds: 0),
                  imageUrl: API_URL +
                      "pokemon/sprite/${pokemon.id.toString().padLeft(3, '0')}",
                  placeholder: (context, url) =>
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        pokemon.pixelmonName,
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 3),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: pokemon.types.map<Widget>((type) {
                            return Container(
                              color: typesColors[type],
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 6),
                              child: Text(
                                type,
                                style: TextStyle(color: getBestContrast(
                                    typesColors[type], Color(0xffffffff),
                                    Color(0xff000000))),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatsRow extends StatelessWidget {
  final PokemonListEntry pokemon;

  StatsRow(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Color(0xff18CA33),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "${pokemon.stats.hp}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xffffffff)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xff13CDEB),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "${pokemon.stats.speed}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xffffffff)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xffF46263),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "${pokemon.stats.attack}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xffffffff)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xffC338D3),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "${pokemon.stats.specialAttack}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xffffffff)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xffDA8525),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "${pokemon.stats.defence}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xffffffff)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xffD1A700),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "${pokemon.stats.specialDefence}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Color(0xffffffff)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
