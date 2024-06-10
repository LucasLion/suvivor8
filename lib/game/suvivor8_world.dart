import 'package:flame/components.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/player.dart';

class Survivor8World extends World with HasGameRef<Survivor8Game> {
  final Player player = Player(onMove: (double x, double y) {});
  final Enemy enemy = Enemy();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(player);
    add(enemy);
  }
}
