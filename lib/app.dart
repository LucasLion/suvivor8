import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/constants.dart';
import 'package:suvivor8/widgets/joystick.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final Survivor8Game game;

  @override
  void initState() {
    super.initState();
    game = Survivor8Game();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FittedBox(
              child: SizedBox(
                width: gameWidth,
                height: gameHeight,
                child: Survivor8GameWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Survivor8GameWidget extends StatelessWidget {
  final Survivor8Game game;

  Survivor8GameWidget({super.key}) : game = Survivor8Game();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: game),
        JoystickAreaCustom(onMove: (dx, dy) async {
          await Future.delayed(const Duration(milliseconds: 10), () {
            game.world.player.move(dx, dy);
          });
        }),
      ],
    );
  }
}
