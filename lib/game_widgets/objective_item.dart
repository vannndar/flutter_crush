import 'package:scafold/model/level.dart';
import 'package:scafold/model/objective.dart';
import 'package:scafold/model/tile.dart';
import 'package:flutter/material.dart';

class ObjectiveItem extends StatelessWidget {
  ObjectiveItem({Key? key, required this.objective, required this.level})
    : super(key: key);

  final Objective objective;
  final Level level;

  @override
  Widget build(BuildContext context) {
    //
    // Trick to get the image of the tile
    //
    Tile tile = Tile(type: objective.type, level: level);
    tile.build();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(width: 32.0, height: 32.0, child: tile.widget),
          Text('${objective.count}', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
