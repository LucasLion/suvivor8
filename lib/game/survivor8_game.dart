import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/settings.dart';
import 'package:suvivor8/game/suvivor8_world.dart';

class Survivor8Game extends FlameGame<Survivor8World>
    with TapDetector, HasCollisionDetection {
  final ath = 'hud';
  Survivor8Game()
      : super(
          world: Survivor8World(),
          camera: CameraComponent.withFixedResolution(
              width: gameWidth, height: gameHeight),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(camera);
    overlays.add(ath);
  }

  @override
  Color backgroundColor() => Colors.black;
}
