import 'package:flutter/material.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/settings.dart';

class LevelUpPage extends StatefulWidget {
  final Survivor8Game game;
  const LevelUpPage({super.key, required this.game});

  @override
  LevelUpPageState createState() => LevelUpPageState();
}

class LevelUpPageState extends State<LevelUpPage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  Widget _item(BuildContext context, Color color) {
    return InkWell(
      onTap: () {
        widget.game.overlays.remove('levelUp');
        widget.game.world.player.gameRef.resumeEngine();
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.amber, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              color: Color(0xff649173),
          ),
          width: gameWidth * 0.75,
          height: gameHeight * 0.15,
          margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround, // Ajustez selon vos besoins
                children: [
                  _image(),
                  Expanded(
                    flex: 1, // _title() prendra une portion d'espace
                    child: _text('title'),
                  ),
                  Expanded(
                    flex:
                        1, // _level() prendra une portion d'espace égale à celle de _title()
                    child: _text('level'),
                  ),
                ],
              ),
              _text('description'),
            ],
          )),
    );
  }

  Widget _text(String text) {
    return const Text(
      'Title',
      textAlign: TextAlign.center,
    );
  }

  Widget _image() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff649173),
      ),
      width: 150,
      height: 150,
      margin: const EdgeInsets.all(15),
      child: const Text('Weapon 1'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        width: gameWidth * 0.7,
        height: gameHeight * 0.6,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 4),
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff649173),
        ),
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                const Text("Level Up",
                    style: TextStyle(fontSize: 30, color: Colors.white)),
                Spacer(),
                _item(context, Colors.red),
                _item(context, Colors.green),
                _item(context, Colors.blue),
              ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
