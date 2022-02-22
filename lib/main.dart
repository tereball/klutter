import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:klutter/Kiwi.dart';

void main() {
  Kiwi game = Kiwi();

  runApp(
    GameWidget(
      game: game,
    ),
  );
}
