import 'dart:io';
import 'dart:ui';

Duration lastDuration = Duration.zero;
Offset center = Offset.zero;
Offset destination = Offset.zero;

void main() {
  //print('das kiwis');
  /*GameEngine engine = GameEngine();
  engine.attach(game);
  engine.start();
  engine.run();*/

  final pixelRatio = window.devicePixelRatio;
  final size = window.physicalSize / pixelRatio;
  center = size.center(Offset.zero);

  window.onBeginFrame = beginFrame;
  window.onPointerDataPacket = pointerDataPacket;
  window.scheduleFrame();
}

void beginFrame(Duration timeStamp) {
  //print('ts: ' + timeStamp.toString());
  final pixelRatio = window.devicePixelRatio;
  final size = window.physicalSize / pixelRatio;
  final physicalBounds = Offset.zero & size * pixelRatio;

  final recorder = PictureRecorder();
  final canvas = Canvas(recorder, physicalBounds);
  canvas.scale(pixelRatio, pixelRatio);

  final paint = Paint()..color = Color(0xFFF44336);
  canvas.drawCircle(center, size.shortestSide / 10, paint);

  final delta = (timeStamp - lastDuration).inMilliseconds / 1000;
  if (delta > 0.016) {
    double dx = 0.0;
    double dy = 0.0;
    double speed = 10;

    if (center.dx < destination.dx) {
      if (center.dx + speed >= destination.dx) {
        dx = destination.dx - center.dx;
      } else {
        dx = speed;
      }
    } else if (center.dx > destination.dx) {
      if (center.dx + speed <= destination.dx) {
        dx = -(destination.dx - center.dx);
      } else {
        dx = -speed;
      }
    }

    if (center.dy < destination.dy) {
      if (center.dy + speed >= destination.dy) {
        dy = destination.dy - center.dy;
      } else {
        dy = speed;
      }
    } else if (center.dy > destination.dy) {
      if (center.dy + speed <= destination.dy) {
        dy = -(destination.dy - center.dy);
      } else {
        dy = -speed;
      }
    }

    dx = (dx / pixelRatio);
    dy = (dy / pixelRatio);
    Offset moveAmount = Offset(dx, dy);
    center += moveAmount;
    lastDuration = timeStamp;
  }

  final picture = recorder.endRecording();
  final sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();
  window.render(sceneBuilder.build());

  window.scheduleFrame();
}

void pointerDataPacket(PointerDataPacket packet) {
  for (final data in packet.data) {
    if (data.change == PointerChange.up) {
      //print('tap up: ' + data.toString() + ' x: ' + data.physicalX.toString());
      final pixelRatio = window.devicePixelRatio;
      destination = Offset(data.physicalX, data.physicalY) / pixelRatio;
    }
  }
}
