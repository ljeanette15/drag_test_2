import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override

  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  Color caughtColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: <Widget>[
        DragBox(Offset(0.0, 0.0), Colors.orange),
        DragBox(Offset(100.0, 0.0), Colors.teal),
      ],
    );
  }
}

// Class for each box that will be dragged around
class RoundBox extends StatelessWidget {
  final Color itemColor;

  const RoundBox({
    super.key,
    required this.itemColor,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: itemColor,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}

// Class for the dragged boxes
class DragBox extends StatefulWidget {
  final Offset initPos;
  final Color itemColor;

  const DragBox(this.initPos, this.itemColor);

  @override
  DragBoxState createState() => DragBoxState();
}

// State for the box that's being dragged around
class DragBoxState extends State<DragBox> {
  Offset position = const Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        data: widget.itemColor,
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = offset;
          });
        },
        feedback: RoundBox(itemColor: widget.itemColor.withOpacity(0.2)),
        child: RoundBox(itemColor: widget.itemColor),
      )
    );
  }

}