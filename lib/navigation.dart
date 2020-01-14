import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 30),
          child: new Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 6),
                    blurRadius: 12,
                    color: Color(0x60000000)),
              ],
              borderRadius: BorderRadius.all(Radius.circular((100.0 - 30 - 15) / 2)),
            ),
            child: new Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular((100.0 - 30 - 15) / 2)),
                color: Color(0xffeaeaea),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    child: SizedBox(
                      height: 100,
                      child: Image(image: AssetImage("assets/pokedex.png")),
                    ),
                    transform: Matrix4.translationValues(-5, -20, 0)..scale(1.2),
                  ),
                  Container(
                    child: SizedBox(
                      height: 100,
                      child: Image(image: AssetImage("assets/biome_disabled.png")),
                    ),
                    transform: Matrix4.translationValues(-5, -20, 0)..scale(1.2),
                  ),
                  Container(
                    child: SizedBox(
                      height: 100,
                      child: Image(image: AssetImage("assets/drop_disabled.png")),
                    ),
                    transform: Matrix4.translationValues(-5, -20, 0)..scale(1.2),
                  ),
                  Container(
                    child: SizedBox(
                      height: 100,
                      child: Image(image: AssetImage("assets/crafting_disabled.png")),
                    ),
                    transform: Matrix4.translationValues(-5, -20, 0)..scale(1.2),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
