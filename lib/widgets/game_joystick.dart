import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class GameJoystick extends JoystickComponent {

  GameJoystick() 
      : super(
          knob: CircleComponent(radius: 150, paint: BasicPalette.red.withAlpha(159).paint()),
          margin: const EdgeInsets.only(left: 0, bottom:0),
          background: CircleComponent(radius: 200, paint: BasicPalette.white.withAlpha(159).paint()),
        );
}
