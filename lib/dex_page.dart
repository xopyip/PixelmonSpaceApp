import 'package:flutter/material.dart';

import 'page_template.dart';

class DexPage extends StatefulWidget {
  DexPage({Key key}) : super(key: key);

  @override
  _DexPageState createState() {
    print("creating state");
    return _DexPageState();
  }
}

class _DexPageState extends State<DexPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: "PokeDex",
        child: Container(
          child: Text("Test"),
        )
    );
  }
}