import 'package:flutter/material.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/app.dart';
import 'package:simple_animated_button/simple_animated_button.dart';

class GameoverPage extends StatefulWidget {
  final Function resetGame;
  const GameoverPage({super.key, required this.resetGame});

  @override
  GameoverPageState createState() => GameoverPageState();
}

class GameoverPageState extends State<GameoverPage> {
  late final ValueListenableBuilder<int> xpListener;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You loose!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 64,
              ),
            ),
            ElevatedLayerButton(
              onClick: () {
                widget.resetGame();
              },
              buttonHeight: 120,
              buttonWidth: 370,
              animationDuration: const Duration(seconds: 1),
              animationCurve: Curves.bounceIn,
              topDecoration: BoxDecoration(
                color: Colors.amber,
                border: Border.all(),
              ),
              topLayerChild: const Text(
                'Reset game',
                style: TextStyle(fontSize: 64),
              ),
              baseDecoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
