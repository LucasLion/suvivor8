import 'package:flame/components.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/player.dart';

class Survivor8World extends World with HasGameRef<Survivor8Game> {
  final Player player = Player();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(player);
  }

  void _update(Duration elasped) {
  }
}
