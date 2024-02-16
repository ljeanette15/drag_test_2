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
  
  var pos = List<Offset>.generate(2, (int index) => Offset(index.toDouble() * 100.0, 0.0), growable: false);
  final initPos = List<Offset>.generate(2, (int index) => Offset(index.toDouble() * 100.0, 0.0));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        // Grid spot 1
        Positioned(
          left: 300.0,
          top: 300.0,
          child: DragTarget(
            onAccept: (int ID) {
              setState(() {
                pos[ID] = Offset(300.0, 300.0);
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
          left: 700.0,
          top: 300.0,
          child: DragTarget(
            onAccept: (int ID) {
              setState(() {
                pos[ID] = Offset(700.0, 300.0);
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
        DragBox(initPos[0], pos[0], Colors.orange, 0),

        // Draggable Box 2
        DragBox(initPos[1], pos[1], Colors.teal, 1),

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
  final Offset pos;
  final Color itemColor;
  final int identifier;

  const DragBox(this.initPos, this.pos, this.itemColor, this.identifier);

  @override
  DragBoxState createState() => DragBoxState();
}

// State for the box that's being dragged around
class DragBoxState extends State<DragBox> {
  Offset position = const Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.pos;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        data: widget.identifier,
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
            position = widget.pos;
          });
        },
        feedback: RoundBox(itemColor: widget.itemColor.withOpacity(0.2)),
        child: RoundBox(itemColor: widget.itemColor),
      )
    );
  }

}