import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Shapes {
  cube, pyramid, crossroads, mess, dots;

  String get displayName => '${name[0].toUpperCase()}${name.substring(1).toLowerCase()}';

  Shape get instance {
    switch (this) {
      case Shapes.cube:
        return Cube();
      case Shapes.pyramid:
        return Pyramid();
      case Shapes.crossroads:
        return Crossroads();
      case Shapes.mess:
        return Mess();
      case Shapes.dots:
        return Dots();
      default:
        throw UnimplementedError();
    }
  }
}

abstract class Shape {
  int nodes;
  List<double> x;
  List<double> y;
  List<double> z;
  List<List<int>> edges;

  List<double> initialXx;
  List<double> initialYy;
  List<double> initialZz;

  Shape(this.nodes, this.x, this.y, this.z, this.edges) :
      initialXx = x.sublist(0),
      initialYy = y.sublist(0),
      initialZz = z.sublist(0);

  void rotateX(double fi) {
    double co = cos(fi);
    double si = sin(fi);
    double yy;

    for (int i = 0; i < nodes; i++) {
      yy = y[i] * co - z[i] * si;
      z[i] = y[i] * si + z[i] * co;
      y[i] = yy;
    }
  }

  void rotateY(double fi) {
    double co = cos(fi);
    double si = sin(fi);
    double zz;

    for (int i = 0; i < nodes; i++) {
      zz = z[i] * co - x[i] * si;
      x[i] = z[i] * si + x[i] * co;
      z[i] = zz;
    }
  }

  void rotateZ(double fi) {
    double co = cos(fi);
    double si = sin(fi);
    double xx;

    for (int i = 0; i < nodes; i++) {
      xx = x[i] * co - y[i] * si;
      y[i] = x[i] * si + y[i] * co;
      x[i] = xx;
    }
  }

  void zoom(double delta) {
    for (int i = 0; i < nodes; i++) {
      x[i] *= delta;
      y[i] *= delta;
      z[i] *= delta;
    }
  }

  void reset() {
    x = initialXx.sublist(0);
    y = initialYy.sublist(0);
    z = initialZz.sublist(0);
  }

  Shapes shape();

  @override
  bool operator ==(other) => identical(this, other)
      || other is Shape
      && listEquals(other.x, x)
      && listEquals(other.y, y)
      && listEquals(other.z, z);

  @override
  int get hashCode => hashValues(hashList(x), hashList(y), hashList(z));
}

class Cube extends Shape {
  Cube() : super(8,
      [-50, 50, 50, -50,  -50, 50, 50, -50],
      [-50, -50, 50, 50, -50, -50, 50, 50],
      [-50, -50, -50, -50, 50, 50, 50, 50],
      [
        [0, 1, 0, 1, 1, 0, 0, 0],
        [0, 0, 1, 0, 0, 1, 0, 0],
        [0, 0, 0, 1, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 1, 0, 1],
        [0, 0, 0, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 0, 0, 0]
      ]);

  @override
  Shapes shape() => Shapes.cube;
}

class Pyramid extends Shape {
  Pyramid() : super(5,
      [-50, 50, 50, -50, 0],
      [50, 50, 50, 50, -50],
      [-50, -50, 50, 50, 0],
      [
        [0, 1, 0, 1, 1],
        [0, 0, 1, 0, 1],
        [0, 0, 0, 1, 1],
        [0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0],
      ]);

  @override
  Shapes shape() => Shapes.pyramid;
}

class Crossroads extends Shape {
  Crossroads() : super(14,
      [-50, 50, 50, -50, -50, 50, 50, -50, 0, 0, -85, 85, 0, 0],
      [-50, -50, 50, 50, -50, -50, 50, 50, 0, 0, 0, 0, -85, 85],
      [-50, -50, -50, -50, 50, 50, 50, 50, -85, 85, 0, 0, 0, 0],
      [
        [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      ]);

  @override
  Shapes shape() => Shapes.crossroads;
}

class Mess extends Shape {
  Mess() : super(14,
      [-50, 50, 50, -50, -50, 50, 50, -50, 0, 0, -85, 85, 0, 0],
      [-50, -50, 50, 50, -50, -50, 50, 50, 0, 0, 0, 0, -85, 85],
      [-50, -50, -50, -50, 50, 50, 50, 50, -85, 85, 0, 0, 0, 0],
      [
        [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      ]);

  @override
  Shapes shape() => Shapes.mess;
}

class Dots extends Shape {
  Dots() : super(14,
      [-50, 50, 50, -50, -50, 50, 50, -50, 0, 0, -85, 85, 0, 0],
      [-50, -50, 50, 50, -50, -50, 50, 50, 0, 0, 0, 0, -85, 85],
      [-50, -50, -50, -50, 50, 50, 50, 50, -85, 85, 0, 0, 0, 0],
      [
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
      ]);

  @override
  Shapes shape() => Shapes.dots;
}
