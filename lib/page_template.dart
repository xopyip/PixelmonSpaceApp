import 'package:flutter/material.dart';

import 'navigation.dart';

class PageTemplate extends StatelessWidget {
  final String title;
  final Container child;

  PageTemplate({Key key, this.child, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -30,
            right: -40,
            child: SizedBox(
              height: 200,
              child: Image(image: AssetImage("assets/pokeball.png")),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            top: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff767676)),),
                child
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navigation(),
    );
  }
}