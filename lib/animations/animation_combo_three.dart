import 'package:scafold/model/combo.dart';
import 'package:scafold/model/tile.dart';
import 'package:flutter/material.dart';

class AnimationComboThree extends StatefulWidget {
  AnimationComboThree({Key? key, required this.combo, required this.onComplete})
    : super(key: key);

  final Combo combo;
  final VoidCallback onComplete;

  @override
  _AnimationComboThreeState createState() => _AnimationComboThreeState();
}

class _AnimationComboThreeState extends State<AnimationComboThree>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              widget.onComplete();
            }
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
          widget.combo.tiles.map((Tile tile) {
            return Positioned(
              left: tile.x,
              top: tile.y,
              child: Transform.scale(
                scale: 1.0 - _controller.value,
                child: tile.widget,
              ),
            );
          }).toList(),
    );
  }
}
