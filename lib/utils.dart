import 'dart:ui';

double abs(double a) {
  if (a < 0) return -a;
  return a;
}

double calcLuminance(Color color) {
  return (0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue);
}

Color getBestContrast(Color a, Color b1, Color b2) {
  if (abs(calcLuminance(a) - calcLuminance(b1)) <
      abs(calcLuminance(a) - calcLuminance(b2))) {
    return b2;
  }
  return b1;
}
