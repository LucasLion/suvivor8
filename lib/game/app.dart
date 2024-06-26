import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/pages/hud.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/pages/gameover_page.dart';
import 'package:suvivor8/pages/level_up_page.dart';
import 'package:suvivor8/pages/loading_page.dart';
import 'package:suvivor8/game/settings.dart';
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
      home: const Scaffold(
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

class Survivor8GameWidget extends StatefulWidget {
  const Survivor8GameWidget({super.key});

  @override
  Survivor8GameWidgetState createState() => Survivor8GameWidgetState();
}

class Survivor8GameWidgetState extends State<Survivor8GameWidget> {
  late Survivor8Game game;

  Survivor8GameWidgetState() {
    game = Survivor8Game();
  }

  void resetGame() {
    setState(() {
      bulletSpeed = 300;
      spawnSpeed = 1.0;
      enemies = 0;
      game = Survivor8Game();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: game, overlayBuilderMap: {
          'hud': (BuildContext context, Survivor8Game game) {
            return Ath(player: game.world.player);
          },
          'gameOver': (BuildContext context, Survivor8Game game) {
            return GameoverPage(resetGame: resetGame);
          },
          'loading': (BuildContext context, Survivor8Game game) {
            return const LoadingPage();
          },
          'levelUp': (BuildContext context, Survivor8Game game) {
            game.world.player.gameRef.pauseEngine();
            return LevelUpPage(game: game);
          },
          'joystick': (BuildContext context, Survivor8Game game) {
            return JoystickAreaCustom(onMove: (double x, double y) {
              game.world.player.move(x, y);
            });
          },
        })
      ],
    );
  }
}
