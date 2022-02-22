import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef {
  Vector2 destination = Vector2(50, 50);
  final double speed = 200.0;
  final double animationSpeed = 0.05;
  bool facingRight = true;

  late SpriteAnimation runLeft;
  late SpriteAnimation standLeft;
  late SpriteAnimation runRight;
  late SpriteAnimation standRight;

  Player() : super(size: Vector2.all(50.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    loadAnimations().then((_) => {animation = standRight});
  }

  Future<void> loadAnimations() async {
    final spriteSheet = SpriteSheet(image: await gameRef.images.load('kiwi-sheet.png'), srcSize: Vector2(96, 96));
    runLeft = spriteSheet.createAnimation(row: 1, stepTime: animationSpeed, to: 2);
    standLeft = spriteSheet.createAnimation(row: 1, stepTime: animationSpeed, to: 1);
    runRight = spriteSheet.createAnimation(row: 0, stepTime: animationSpeed, to: 2);
    standRight = spriteSheet.createAnimation(row: 0, stepTime: animationSpeed, to: 1);
  }

  @override
  void update(double delta) {
    super.update(delta);
    double modifier = (delta * speed);

    if (position.y > destination.y) {
      if (position.y + -modifier < destination.y) {
        position.y = destination.y;
      } else {
        position.add(Vector2(0, -modifier));
      }
    } else if (position.y <= destination.y) {
      if (position.y + modifier > destination.y) {
        position.y = destination.y;
      } else {
        position.add(Vector2(0, modifier));
      }
    }

    // move left
    if (position.x > destination.x) {
      if (position.x + modifier < destination.x) {
        position.x = destination.x;
      } else {
        position.add(Vector2(-modifier, 0));
        animation = runLeft;
      }

      // move right
    } else if (position.x < destination.x) {
      if (position.x + modifier >= destination.x) {
        position.x = destination.x;
      } else {
        position.add(Vector2(modifier, 0));
        animation = runRight;
      }
    }

    // done moving
    if (position.x == destination.x && position.y == destination.y) {
      if (animation == runLeft) {
        animation = standLeft;
      } else if (animation == runRight) {
        animation = standRight;
      }
    }
  }

  void setDestination(Vector2 dest) {
    destination.x = dest.x.floorToDouble();
    destination.y = dest.y.floorToDouble();
  }
}
