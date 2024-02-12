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
  // TO DO: Make a list that holds each block's positions. Also make each block
  //        have a unique index that it carries as its data. When that block is
  //        accepted by a DragTarget, the dragtarget updates the position list
  //        at the index of that block
  
  Offset pos1 = Offset(0.0, 0.0);
  Offset pos2 = Offset(100.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        // Grid spot 1
        Positioned(
          left: 200.0,
          top: 100.0,
          child: DragTarget(
            onAccept: (Offset pos) {
              setState(() {
                pos1 = Offset(200.0, 100.0);
              });
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return RoundBox(itemColor: Colors.grey);
            }
          ),
        ),

        // Grid spot 2
        Positioned(
          left: 300.0,
          top: 100.0,
          child: DragTarget(
            onAccept: (Offset pos) {
              setState(() {
                pos1 = Offset(300.0, 100.0);
              });
            },
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return RoundBox(itemColor: Colors.grey);
            }
          ),
        ),

        // Draggable Box 1
        DragBox(pos1, Colors.orange),

        // Draggable Box 2
        DragBox(pos2, Colors.teal),

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
        data: position,
        onDragCompleted: () {
          setState(() {
          });
        },
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            position = widget.initPos;
          });
        },
        onDragEnd: (dragDetails) {
          setState(() {
            position = widget.initPos;
          });
        },
        feedback: RoundBox(itemColor: widget.itemColor.withOpacity(0.2)),
        child: RoundBox(itemColor: widget.itemColor),
      )
    );
  }

}