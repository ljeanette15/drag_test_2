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
  // TO DO: DragTarget is correctly accepting the Draggable, but the position is not being updated. The target
  //         accepts based on where the cursor is. Somehow the position is not being passed correctly. It seems
  //         like the square is being rendered before the array is updated?
  
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
            onLeave: (ID) {
            },
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
              return RoundBox(itemColor: Colors.grey, width: 100.0);
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
              return RoundBox(itemColor: Colors.grey, width: 100.0);
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
  final double width;

  const RoundBox({
    super.key,
    required this.itemColor,
    required this.width,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width,
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
  bool cancelled = false;

  // @override
  // void initState() {
  //   super.initState();
  //   position = widget.pos;
  // }

  @override
  Widget build(BuildContext context) {
    if(cancelled == true){
      position = widget.initPos;
    } else {
      position = widget.pos;
    }
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        data: widget.identifier,
        onDragCompleted: () {
          setState(() {
            cancelled = false;
            position = widget.pos;
          });
        },
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            cancelled = true;
          });
        },
        feedback: RoundBox(itemColor: widget.itemColor.withOpacity(0.2), width: 85.0),
        child: RoundBox(itemColor: widget.itemColor, width: 100.0),
      )
    );
  }
}