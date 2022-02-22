import 'package:flame/components.dart';

class World extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('winter-bg.jpg');
    size = sprite!.originalSize * 1.3;
    return super.onLoad();
  }
}
