import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class JoystickAreaCustom extends StatefulWidget {
  final Function(double, double) onMove;

  JoystickAreaCustom({required this.onMove});

  @override
  _JoystickAreaCustomState createState() => _JoystickAreaCustomState();
}

class _JoystickAreaCustomState extends State<JoystickAreaCustom>
    with TickerProviderStateMixin {
  double _x = 0;
  double _y = 0;
  double _targetX = 0;
  double _targetY = 0;

  final JoystickMode _joystickMode = JoystickMode.all;
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_update)..start();
  }

  void _update(Duration elapsed) {
    setState(() {
      _x = _x + (_targetX - _x);
      _y = _y + (_targetY - _y);
      widget.onMove(_x, _y);
    });
  }

  @override
  Widget build(BuildContext context) {
    return JoystickArea(
      mode: _joystickMode,
      initialJoystickAlignment: const Alignment(0, 0.8),
      listener: (details) {
        _targetX = details.x * 10;
        _targetY = details.y * 10;
      },
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}