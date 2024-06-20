import 'package:flutter/material.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/app.dart';

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
            Container(
              padding: EdgeInsets.only(top: 20),
              width: 200,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  widget.resetGame();
                },
                child: const Text('Retry', style: TextStyle(fontSize: 48)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
