import 'package:flutter/widgets.dart';
import 'package:pixelmon_space/api/models/pokemon_models.dart';

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
