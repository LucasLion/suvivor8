import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:suvivor8/constants.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/player.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Survivor8World extends World with HasGameRef<Survivor8Game> {
  final Player player = Player(onMove: (double x, double y) {});
  late double timer = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    TiledComponent mapComponent =
      await TiledComponent.load('map.tmx', Vector2.all(worldScale));
    add(mapComponent);
    add(player);
    gameRef.camera.follow(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // spawn every 2 seconds
    timer += dt;
    if (timer >= .5) {
      timer = 0;
      spawnEnemy();
    }
  }

  void spawnEnemy() {
    Random random = Random();
    double x = random.nextDouble() * gameRef.size.x;
    double y = random.nextDouble() * gameRef.size.y;
    Vector2 randomPosition = Vector2(x, y);
    gameRef.world.add(Enemy(randomPosition));
  }
}
