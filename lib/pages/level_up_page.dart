import 'package:flutter/material.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/game/settings.dart';
import 'package:suvivor8/game/upgrade.dart';

class LevelUpPage extends StatefulWidget {
  final Survivor8Game game;
  const LevelUpPage({super.key, required this.game});

  @override
  LevelUpPageState createState() => LevelUpPageState();
}

class LevelUpPageState extends State<LevelUpPage>
    with SingleTickerProviderStateMixin {

  List<Upgrade> getRandomUpgrades(int count) {
    List<Upgrade> filtered = upgrades.where((upgrade) {
      if (upgrade.id == 'number (rings)' &&
          widget.game.world.player.ring.numberOfRings >=
              widget.game.world.player.ring.maxNumberOfRings) {
        print('condition entered');
        return false;
      }
      return true;
    }).toList();
    filtered.shuffle();
    return filtered.take(count).toList();
  }

  Widget _item(BuildContext context, Upgrade upgrade) {
    return InkWell(
      onTap: () {
        upgrade.action(widget.game);
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
            color: const Color(0xff649173),
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
                  _image(upgrade.image),
                  Expanded(
                    flex: 1,
                    child: _text(upgrade.name),
                  ),
                  Expanded(
                    flex: 1,
                    child: _text(upgrade.id),
                  ),
                ],
              ),
              _text(upgrade.description),
            ],
          )),
    );
  }

  Widget _text(String text) {
    return Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 40,
        ));
  }

  Widget _image(AssetImage image) {
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
        color: const Color(0xff649173),
      ),
      width: 150,
      height: 150,
      margin: const EdgeInsets.all(15),
      child: Image(image: image),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Upgrade> selectedUpgrades = getRandomUpgrades(3);

    return Center(
      child: AnimatedContainer(
        duration: const Duration(seconds: 3),
        width: gameWidth * 0.7,
        height: gameHeight * 0.6,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 4),
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff649173),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text("Level Up",
                  style: TextStyle(fontSize: 60, color: Colors.amber)),
              const Spacer(),
              _item(context, selectedUpgrades[0]),
              _item(context, selectedUpgrades[1]),
              _item(context, selectedUpgrades[2]),
            ]),
      ),
    );
  }
}
