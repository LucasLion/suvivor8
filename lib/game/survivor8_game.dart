import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/game/suvivor8_world.dart';
import 'package:suvivor8/constants.dart';

class Survivor8Game extends FlameGame<Survivor8World> {

  Survivor8Game()
      : super(
          world: Survivor8World(),
          camera: CameraComponent.withFixedResolution(
              width: gameWidth, height: gameHeight),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  Color backgroundColor() => Colors.green;


}
