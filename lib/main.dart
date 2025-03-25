import 'package:flutter/material.dart';
import 'package:scafold/application.dart';
import 'package:scafold/helpers/audio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  // Initialize the audio
  //
  await Audio.init();

  //
  // Remove the status bar
  //

  return runApp(
    Application(),
  );
}
