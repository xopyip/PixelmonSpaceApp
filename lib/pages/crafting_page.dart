import 'package:flutter/material.dart';

import '../page_template.dart';

class CraftingPage extends StatefulWidget {
  CraftingPage({Key key}) : super(key: key);

  @override
  _CraftingPageState createState() {
    return _CraftingPageState();
  }
}

class _CraftingPageState extends State<CraftingPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        page: this.widget,
        title: "Crafting",
        child: Container(
          child: Text("Test"),
        ));
  }
}
