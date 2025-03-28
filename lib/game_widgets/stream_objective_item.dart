import 'dart:async';

import 'package:scafold/bloc/bloc_provider.dart';
import 'package:scafold/bloc/game_bloc.dart';
import 'package:scafold/bloc/objective_bloc.dart';
import 'package:scafold/model/objective.dart';
import 'package:scafold/model/objective_event.dart';
import 'package:scafold/model/tile.dart';
import 'package:flutter/material.dart';

class StreamObjectiveItem extends StatefulWidget {
  StreamObjectiveItem({Key? key, required this.objective}) : super(key: key);

  final Objective objective;

  @override
  StreamObjectiveItemState createState() {
    return new StreamObjectiveItemState();
  }
}

class StreamObjectiveItemState extends State<StreamObjectiveItem> {
  late ObjectiveBloc _bloc;
  late GameBloc gameBloc;

  ///
  /// In order to determine whether this particular Objective is
  /// part of the list of Objective Events, we need to inject the stream
  /// that gives us the list of all Objective Events to THIS instance
  /// of the BLoC
  ///
  StreamSubscription? _subscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Now that the context is available, retrieve the gameBloc
    gameBloc = BlocProvider.of<GameBloc>(context)!.bloc;
    _createBloc();
  }

  ///
  /// As Widgets can be changed by the framework at any time,
  /// we need to make sure that if this happens, we keep on
  /// listening to the stream that notifies us about Objectives
  ///
  @override
  void didUpdateWidget(StreamObjectiveItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeBloc();
    _createBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  void _createBloc() {
    _bloc = ObjectiveBloc(widget.objective.type);

    // Simple pipe from the stream that lists all the ObjectiveEvents into
    // the BLoC that processes THIS particular Objective type
    _subscription = gameBloc.outObjectiveEvents.listen(
      (ObjectiveEvent e) => _bloc.sendObjectives(e),
    );
  }

  void _disposeBloc() {
    _subscription?.cancel();
    _subscription = null;
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    // Trick to get the image of the tile
    //
    Tile tile = Tile(
      type: widget.objective.type,
      level: gameBloc.gameController.level,
    );
    tile.build();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(width: 32.0, height: 32.0, child: tile.widget),
          StreamBuilder<int>(
            initialData: widget.objective.count,
            stream: _bloc.objectiveCounter,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text(
                '${snapshot.data}',
                style: TextStyle(color: Colors.black),
              );
            },
          ),
        ],
      ),
    );
  }
}
