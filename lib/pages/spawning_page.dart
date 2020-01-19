import 'package:flutter/material.dart';

import '../page_template.dart';

class SpawningPage extends StatefulWidget {
  SpawningPage({Key key}) : super(key: key);

  @override
  _SpawningPageState createState() {
    return _SpawningPageState();
  }
}

class _SpawningPageState extends State<SpawningPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: "Spawning",
        page: this.widget,
        child: Container(
          child: Text("Test"),
        ));
  }
}
