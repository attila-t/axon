import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings.dart';
import 'shape.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => Settings(),
    child: const Axon(),
  ),
);

class Axon extends StatelessWidget {
  const Axon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Axon',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
        ),
      ),
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(title: "Home"),
      '/settings': (context) => const SettingsPage(title: "Settings"),
      '/shapes': (context) => const ShapesPage(title: "Shapes"),
      '/help': (context) => const HelpPage(title: "Help"),
    }
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _scale = 0;

  ShapePainter _buildPainter() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    return ShapePainter(
      color: settings.color,
      strokeWidth: settings.strokeWidth,
      shape: settings.shape,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() {
          Shape shape = context.read<Settings>().shape;
          shape.rotateX(pi * -details.focalPointDelta.dy / 180);
          shape.rotateY(pi * details.focalPointDelta.dx / 180);
          if (details.pointerCount > 1) {
            shape.zoom(1 + (details.scale - _scale > 0 ? 1 : -1) * details.scale / 100);
            _scale = details.scale;
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            painter: _buildPainter(),
            child: Center(
              child: Container(
              ),
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: BottomAppBar(
      color: Colors.green,
      notchMargin: 10,
      shape: const CircularNotchedRectangle(),
      child: IconTheme(
        data: const IconThemeData(
          color: Colors.white,
          size: 30,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  Navigator.pushNamed(context, "/settings").then((_) => setState(() { }));
                },
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                icon: const Icon(Icons.rectangle_outlined),
                onPressed: () {
                  Navigator.pushNamed(context, "/shapes").then((_) => setState(() { }));
                },
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                icon: const Icon(Icons.help_outlined),
                onPressed: () {
                  Navigator.pushNamed(context, "/help");
                },
              ),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: () {
        Shape shape = context.read<Settings>().shape;
        shape.reset();
      },
      child: const Icon(Icons.restart_alt),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
  );
}

class ShapePainter extends CustomPainter {
  const ShapePainter({required this.color, required this.strokeWidth, required this.shape});

  final Color color;
  final double strokeWidth;
  final Shape shape;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    // end at nodes (instead of nodes - 1) to draw dots only as well
    for (int i = 0; i < shape.nodes; i++) {
      // start at i (instead of i + 1) to draw dots only as well
      for (int j = i; j < shape.nodes; j++) {
        if (shape.edges[i][j] != 0) {
          if (i == j) {
            canvas.drawCircle(Offset(centerX + shape.x[i], centerY + shape.y[i]), strokeWidth, paint);

          } else {
            canvas.drawLine(Offset(centerX + shape.x[i], centerY + shape.y[i]),
                Offset(centerX + shape.x[j], centerY + shape.y[j]), paint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(ShapePainter oldDelegate) {
    return color != oldDelegate.color
        || strokeWidth != oldDelegate.strokeWidth
        || shape != oldDelegate.shape
        || true;  // TODO: shouldn't it work without this?
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const _availableColors = [
    Color(0xff000000),
    Color(0xffff6770),
    Color(0xffffb000),
    Color(0xffffe600),
    Color(0xff7fdd05),
    Color(0xff00a585),
    Color(0xff22bcf2),
    Color(0xff1256cc),
    Color(0xff803ad0),
    Color(0xffb568f2),
  ];

  late Color _color;
  late double _strokeWidth;

  @override
  void initState() {
    super.initState();

    Settings settings = context.read<Settings>();
    _color = settings.color;
    _strokeWidth = settings.strokeWidth;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            width: double.infinity,
            height: 120,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 50,
                childAspectRatio: 1 / 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: _availableColors.length,
              itemBuilder: (context, index) {
                final itemColor = _availableColors[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _color = itemColor;
                    });
                  },
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: itemColor,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    child: itemColor == _color
                        ? const Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
                  ),
                );
              },
            ),
          ),
          Text(
            'Stroke Width',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Slider(
            min: 1.0,
            max: 5.0,
            divisions: 5 - 1,
            value: _strokeWidth,
            label: _strokeWidth.round().toString(),
            onChanged: (double value) {
              setState(() {
                _strokeWidth = value;
              });
            },
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: () {
        Settings settings = context.read<Settings>();
        settings.color = _color;
        settings.strokeWidth = _strokeWidth;
        Navigator.pop(context);
      },
      child: const Icon(Icons.check),
    ),
  );
}

class ShapesPage extends StatefulWidget {
  const ShapesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ShapesPage> createState() => _ShapesPageState();
}

class _ShapesPageState extends State<ShapesPage> {
  late Shapes? _shape;

  @override
  void initState() {
    super.initState();
    Settings settings = context.read<Settings>();
    _shape = settings.shape.shape();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Shapes.values.length,
              itemBuilder: (context, index) => RadioListTile(
                title: Text(
                  Shapes.values[index].displayName,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                value: Shapes.values[index],
                groupValue: _shape,
                onChanged: (Shapes? value) {
                  setState(() {
                    _shape = value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: () {
        Settings settings = context.read<Settings>();
        settings.shape = _shape?.instance ?? Cube();  // TODO: magic -> _shape.instance
        Navigator.pop(context);
      },
      child: const Icon(Icons.check),
    ),
  );
}

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You\'re beyond salvation...',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    ),
  );
}
