import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortrait();
  runApp(GameApp());
}
