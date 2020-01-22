import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';

class MovesInfoTab extends StatelessWidget {
  final Pokemon pokemon;

  MovesInfoTab(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Table(
          border: TableBorder(
            horizontalInside: BorderSide(color: Color(0xffdddddd)),
            verticalInside: BorderSide(color: Color(0xffdddddd)),
          ),
          children: [
            TableRow(children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "Level",
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              TableCell(
                child: Text("Atak"),
              ),
              /*TableCell(child: Text("Kategoria"),),
                TableCell(child: Text("Typ"),),*/
            ]),
          ]..addAll(pokemon.levelUpMoves.keys.map((level) {
              return pokemon.levelUpMoves[level]
                  .map((move) => TableRow(children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              level,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Text(move),
                        ),
                      ]))
                  .toList();
            }).reduce((a, b) => a..addAll(b))),
        )
      ],
    );
  }
}
