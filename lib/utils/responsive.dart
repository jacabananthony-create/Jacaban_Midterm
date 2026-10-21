import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  Responsive(this.context);

  Size get size => MediaQuery.sizeOf(context);
  double get width => size.width;
  bool get isLandscape =>
      MediaQuery.orientationOf(context) == Orientation.landscape;
  bool get isSmall => width < 360;
  bool get isLarge => width >= 700;

  double get pagePadding => isSmall ? 14 : (isLarge ? 40 : 20);

  double font(double base) =>
      isSmall ? base * 0.9 : (isLarge ? base * 1.15 : base);

  double get maxContentWidth => 960;
}