import 'package:flutter/material.dart';
import 'package:pixelmon_space/pages/crafting_page.dart';
import 'package:pixelmon_space/pages/dex_page.dart';
import 'package:pixelmon_space/pages/drop_page.dart';
import 'package:pixelmon_space/pages/spawning_page.dart';

class Navigation extends StatefulWidget {
  GlobalKey<NavigatorState> navigationKey;
  int currentRoute = 0;

  Widget page;

  Navigation(this.page, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NavigationState(this.page);
  }
}

class _NavigationState extends State<Navigation> {
  List<_NavigationItem> items = [
    _NavigationItem("pokedex", "/dex", (w) => w is DexPage),
    _NavigationItem("biome", "/spawning", (w) => w is SpawningPage),
    _NavigationItem("drop", "/drop", (w) => w is DropPage),
    _NavigationItem("crafting", "/crafting", (w) => w is CraftingPage),
  ];

  Widget page;

  _NavigationState(this.page);

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
      height: 70,
      color: Color(0xffffffff),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
        child: new Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  color: Color(0x60000000)),
            ],
            borderRadius: BorderRadius.all(Radius.circular((70 - 15) / 2)),
          ),
          child: new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular((70 - 15) / 2)),
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
    return GestureDetector(
      child: Container(
        child: SizedBox(
          height: 100,
          child: Image(
              image: AssetImage(_getImageName(item, !item.check(this.page)))),
        ),
        transform: Matrix4.translationValues(-5, -20, 0)
          ..scale(1.2),
      ),
      onTap: () {
        if (item.check(this.page)) {
          return;
        }
        Navigator.of(context).pushReplacementNamed(item.routeName);
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
  bool Function(Widget) check;

  _NavigationItem(this.imageName, this.routeName, this.check);
}
