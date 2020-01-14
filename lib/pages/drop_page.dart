import 'package:flutter/material.dart';

import '../page_template.dart';

class DropPage extends StatefulWidget {
  DropPage({Key key}) : super(key: key);

  @override
  _DropPageState createState() {
    return _DropPageState();
  }
}

class _DropPageState extends State<DropPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: "Drop",
        child: Container(
          child: Text("Test"),
        ));
  }
}
