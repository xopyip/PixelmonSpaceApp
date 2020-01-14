import 'package:flutter/material.dart';

class NoTransitionPage extends PageTransitionsBuilder {
  const NoTransitionPage();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
