import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:suvivor8/settings.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/player.dart';
import 'package:suvivor8/xp.dart';

class Survivor8World extends World with HasGameRef<Survivor8Game> {
  final Player player = Player(onMove: (double x, double y) {});
  late double timer = 0;
  late List<Xp> xpList = [];

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // TiledComponent component =
    //   await TiledComponent.load('map.tmx', Vector2.all(worldScale));
    // add(component);
    final image = await Flame.images.load('map.png');
    final sprite = Sprite(image);
    final size = Vector2(mapSize, mapSize);
    final component = SpriteComponent(sprite: sprite, size: size);
    component.position = Vector2(-mapSize/2, -mapSize/2);
    add(component);
    add(player);
    gameRef.camera.follow(player);
    gameRef.camera.setBounds(
      Polygon([
        Vector2(-mapSize/2 + gameRef.size.x/2, -mapSize/2 + gameRef.size.y/2),
        Vector2(mapSize/2 - gameRef.size.x/2, -mapSize/2 + gameRef.size.y/2),
        Vector2(mapSize/2 - gameRef.size.x/2, mapSize/2 - gameRef.size.y/2),
        Vector2(-mapSize/2 + gameRef.size.x/2, mapSize/2 - gameRef.size.y/2),
      ]),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    // spawn every 2 seconds
    timer += dt;
    if (timer >= spawnSpeed && enemies < 100) {
      timer = 0;
      spawnEnemy();
      enemies += 1;
    }
  }

  void spawnEnemy() {
    Random random = Random();
    double x = 0, y = 0;

    // Choisissez une bordure au hasard
    int edge = random.nextInt(4);

    switch (edge) {
      case 0: // Bordure supérieure
        x = player.position.x + (random.nextDouble() * 2 - 1) * gameRef.size.x / 2;
        y = player.position.y - gameRef.size.y / 2;
        break;
      case 1: // Bordure droite
        x = player.position.x + gameRef.size.x / 2;
        y = player.position.y + (random.nextDouble() * 2 - 1) * gameRef.size.y / 2;
        break;
      case 2: // Bordure inférieure
        x = player.position.x + (random.nextDouble() * 2 - 1) * gameRef.size.x / 2;
        y = player.position.y + gameRef.size.y / 2;
        break;
      case 3: // Bordure gauche
        x = player.position.x - gameRef.size.x / 2;
        y = player.position.y + (random.nextDouble() * 2 - 1) * gameRef.size.y / 2;
        break;
    }

    Vector2 randomPosition = Vector2(x, y);
    gameRef.world.add(Enemy(randomPosition));
  }
}
