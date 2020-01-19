import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Color backgroundColor;

  final Color textColor;

  final String text;

  const Badge({Key key, this.backgroundColor, this.textColor, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 2), blurRadius: 4)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Text(
            text,
            style: TextStyle(fontSize: 19, color: textColor),
          ),
        ),
      ),
    );
  }
}
