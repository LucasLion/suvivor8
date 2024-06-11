import 'dart:math';

import 'package:flame/components.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/player.dart';

class Survivor8World extends World with HasGameRef<Survivor8Game> {
  final Player player = Player(onMove: (double x, double y) {});
  late double timer = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // spawn every 2 seconds
    timer += dt;
    if (timer >= 2) {
      timer = 0;
      spawnEnemy();
    }
  }

  void spawnEnemy() {
    Random random = Random();
    double x = random.nextDouble() * gameRef.size.x - gameRef.size.x / 2;
    double y = random.nextDouble() * gameRef.size.y - gameRef.size.y / 2;
    Vector2 randomPosition = Vector2(x, y);
    add(Enemy(randomPosition));
  }
}
