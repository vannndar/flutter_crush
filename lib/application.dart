import 'package:scafold/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:scafold/bloc/bloc_provider.dart';
import 'package:scafold/bloc/game_bloc.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      bloc: GameBloc(),
      child: MaterialApp(
        title: 'Flutter Crush',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
