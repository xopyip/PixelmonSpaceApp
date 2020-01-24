import 'package:flutter/material.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';

class MovesInfoTab extends StatelessWidget {
  final Pokemon pokemon;

  MovesInfoTab(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Table(
          columnWidths: {
            0: IntrinsicColumnWidth()
          },
          border: TableBorder(
            verticalInside: BorderSide(color: Color(0xffdddddd)),
            horizontalInside: BorderSide(color: Color(0xffdddddd)),
          ),
          children: [
            TableRow(children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Level",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Atak"),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Kategoria"),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Typ"),
                ),
              ),
            ]),
          ]..addAll(pokemon.levelUpMoves.keys.map((level) {
            return pokemon.levelUpMoves[level]
                .map((move) => TableRow(children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    level,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(move.attackName),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(move.attackCategory),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(move.attackType),
                ),
              ),
            ]))
                .toList();
          }).reduce((a, b) => a..addAll(b))),
        ),
        SizedBox(height: 50,)
      ],
    );
  }
}
