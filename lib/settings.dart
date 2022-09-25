import 'package:flutter/material.dart';

import 'shape.dart';

class Settings extends ChangeNotifier {
  Color _color = Colors.black;
  double _strokeWidth = 3;
  Shape _shape = Cube();

  Color get color => _color;

  set color(Color color) {
    _color = color;
    notifyListeners();
  }

  double get strokeWidth => _strokeWidth;

  set strokeWidth(double strokeWidth) {
    _strokeWidth = strokeWidth;
    notifyListeners();
  }

  Shape get shape => _shape;

  set shape(Shape shape) {
    _shape = shape;
    notifyListeners();
  }

  // singleton
  static final Settings _instance = Settings._internal();

  factory Settings() {
    return _instance;
  }

  Settings._internal();
}
