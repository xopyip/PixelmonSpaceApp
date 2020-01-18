import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';

import '../constants.dart';

class PokemonInfoPage extends StatefulWidget {
  final PokemonListEntry pokemon;
  final GlobalKey<NavigatorState> navigationKey;

  PokemonInfoPage(this.pokemon, this.navigationKey);

  @override
  _PokemonInfoPageState createState() =>
      _PokemonInfoPageState(this.pokemon, this.navigationKey);
}

class _PokemonInfoPageState extends State<PokemonInfoPage> {
  PokemonListEntry pokemon;
  final GlobalKey<NavigatorState> navigationKey;

  _PokemonInfoPageState(this.pokemon, this.navigationKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: Stack(
        children: <Widget>[
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
          Positioned(
            top: -30,
            right: -40,
            child: SizedBox(
              height: 200,
              child: Image(image: AssetImage("assets/pokeball.png")),
            ),
          ),
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
                        this.navigationKey.currentState.pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Color(0xffffffff),
                      ),
                    )),
                Text(
                  this.pokemon.pixelmonName,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffffffff)),
                ),
              ],
            ),
          ),
          Positioned(
            top: 140,
            right: 5,
            child: Container(
              child: CachedNetworkImage(
                width: 150,
                height: 150,
                fadeOutDuration: Duration(microseconds: 0),
                imageUrl: API_URL +
                    "pokemon/sprite/${this.pokemon.id.toString().padLeft(3, '0')}",
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
                  width: 150,
                  height: 150,
                  filterQuality: FilterQuality.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
