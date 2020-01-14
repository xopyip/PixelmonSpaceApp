import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  GlobalKey<NavigatorState> navigationKey;
  int currentRoute = 0;

  Navigation(this.navigationKey, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NavigationState(navigationKey);
  }

}

class _NavigationState extends State<Navigation> {
  GlobalKey<NavigatorState> navigationKey;
  int currentRoute = 0;
  List<_NavigationItem> items = [
    _NavigationItem("pokedex", "/dex"),
    _NavigationItem("biome", "/spawning"),
    _NavigationItem("drop", "/drop"),
    _NavigationItem("crafting", "/crafting"),
  ];

  _NavigationState(this.navigationKey);

  @override
  void initState() {
    setState(() {
      currentRoute = 0;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    for (var value in items) {
      precacheImage(AssetImage(_getImageName(value, true)), context);
      precacheImage(AssetImage(_getImageName(value, false)), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Color(0xffffffff),
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
            borderRadius:
            BorderRadius.all(Radius.circular((100.0 - 30 - 15) / 2)),
          ),
          child: new Container(
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular((100.0 - 30 - 15) / 2)),
              color: Color(0xffeaeaea),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.map((item) => createLink(context, item)).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget createLink(BuildContext context, _NavigationItem item) {
    var idx = items.indexOf(item);
    return GestureDetector(
      child: Container(
        child: SizedBox(
          height: 100,
          child: Image(
              image: AssetImage(_getImageName(item, currentRoute != idx))),
        ),
        transform: Matrix4.translationValues(-5, -20, 0)
          ..scale(1.2),
      ),
      onTap: () {
        if (currentRoute == idx) {
          return;
        }
        setState(() {
          currentRoute = idx;
        });
        navigationKey.currentState.pushReplacementNamed(item.routeName);
      },
    );
  }

  String _getImageName(_NavigationItem item, bool disabled) {
    return "assets/" + item.imageName + (disabled ? "_disabled" : "") + ".png";
  }
}

class _NavigationItem {
  String imageName;
  String routeName;

  _NavigationItem(this.imageName, this.routeName);

}
