import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:klutter/Player.dart';
import 'package:klutter/World.dart';

import 'package:flutter/services.dart';

class Kiwi extends FlameGame with TapDetector {
  final Player player = Player();
  final World world = World();

  @override
  Future<void> onLoad() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);

    await add(world);
    add(player);
  }

  void update(double dt) {
    super.update(dt);
  }

  @override
  bool onTapDown(TapDownInfo event) {
    print("Player tap down on ${event.eventPosition.game}");
    return true;
  }

  @override
  bool onTapUp(TapUpInfo event) {
    print("Player tap up on ${event.eventPosition.game}");
    player.setDestination(event.eventPosition.game);

    return true;
  }
}
