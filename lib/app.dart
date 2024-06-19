import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/pages/hud.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/pages/loose_page.dart';
import 'package:suvivor8/settings.dart';
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
                height: gameHeight + 1,
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
  bool isFirstMove = true;

  Survivor8GameWidget({super.key}) : game = Survivor8Game();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(
          game: game,
          overlayBuilderMap: {
            'hud': (BuildContext context, Survivor8Game game) {
              return Ath(player: game.world.player);
            },
            'gameOver': (BuildContext context, Survivor8Game game) {
              return const LooseScreen();
            },
          },
        ),
        game.overlays.isActive('gameOver') ? Container() : JoystickAreaCustom(onMove: (dx, dy) async {
          if (isFirstMove) {
            await Future.delayed(const Duration(milliseconds: 100));
            isFirstMove = false;
          }
          game.world.player.move(dx, dy);
        }),
      ],
    );
  }
}
