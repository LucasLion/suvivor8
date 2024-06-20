import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:suvivor8/settings.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/player.dart';
import 'package:suvivor8/widgets/game_joystick.dart';
import 'package:suvivor8/xp.dart';

class Survivor8World extends World
    with HasGameRef<Survivor8Game>, TapCallbacks {
  final Player player = Player(onMove: (double x, double y) {});
  late double timer = 0;
  late List<Xp> xpList = [];
  late final GameJoystick joystick;
  late Vector2 joystickSize;
  late PositionComponent joystickWrapper;
  late Vector2 joystickPosition;
  late Vector2 touchPosition;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // TiledComponent component =
    //   await TiledComponent.load('bigmap.tmx', Vector2.all(worldScale));
    // add(component);
    game.overlays.add('joystick');
    // joystick = GameJoystick();
    final image = await Flame.images.load('map.png');
    final sprite = Sprite(image);
    final size = Vector2(mapSize, mapSize);
    final map = SpriteComponent(sprite: sprite, size: size);
    map.position = Vector2(-mapSize / 2, -mapSize / 2);
    gameRef.world.add(map);
    gameRef.world.add(player);
    gameRef.camera.follow(player);
    gameRef.camera.setBounds(
      Polygon([
        Vector2(-mapSize / 2 + gameRef.size.x / 2,
            -mapSize / 2 + gameRef.size.y / 2),
        Vector2(mapSize / 2 - gameRef.size.x / 2,
            -mapSize / 2 + gameRef.size.y / 2),
        Vector2(
            mapSize / 2 - gameRef.size.x / 2, mapSize / 2 - gameRef.size.y / 2),
        Vector2(-mapSize / 2 + gameRef.size.x / 2,
            mapSize / 2 - gameRef.size.y / 2),
      ]),
    );

    // ---------------------- joystick ----------------------
    // print('x: ${gameRef.size.x / 2}, y: ${gameRef.size.y}');
    // joystickSize = Vector2(gameRef.size.x / 2 - 50, gameRef.size.y / 2 - 100);
    // joystickPosition = Vector2(0, 0);
    // joystickWrapper =
    //     PositionComponent(size: joystickSize, position: joystickPosition);
    // joystickWrapper.add(joystick);
    // gameRef.world.add(joystickWrapper);
    // touchPosition = Vector2(0, 0);
    // ---------------------- joystick ----------------------
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer += dt;
    if (timer >= spawnSpeed && enemies < 100) {
      timer = 0;
      spawnEnemy();
      enemies += 1;
    }
    // joystickWrapper.position = Vector2(gameRef.camera.viewfinder.position.x,
    //     gameRef.camera.viewfinder.position.y);
    // joystickWrapper.position = Vector2(touchPosition.x - gameRef.size.x/2, touchPosition.y - gameRef.size.x/2;
  }

  void spawnEnemy() {
    Random random = Random();
    double x = 0, y = 0;

    // Choisissez une bordure au hasard
    int edge = random.nextInt(4);

    switch (edge) {
      case 0:
        x = player.position.x +
            (random.nextDouble() * 2 - 1) * gameRef.size.x / 2;
        y = player.position.y - gameRef.size.y / 2;
        break;
      case 1:
        x = player.position.x + gameRef.size.x / 2;
        y = player.position.y +
            (random.nextDouble() * 2 - 1) * gameRef.size.y / 2;
        break;
      case 2:
        x = player.position.x +
            (random.nextDouble() * 2 - 1) * gameRef.size.x / 2;
        y = player.position.y + gameRef.size.y / 2;
        break;
      case 3:
        x = player.position.x - gameRef.size.x / 2;
        y = player.position.y +
            (random.nextDouble() * 2 - 1) * gameRef.size.y / 2;
        break;
    }

    Vector2 randomPosition = Vector2(x, y);
    gameRef.world.add(Enemy(randomPosition));
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   super.onTapDown(event);
  //   touchPosition = event.localPosition;
  //   print('touchposition: $touchPosition');
  // }

  // @override
  // void onTapUp(TapUpEvent event) {
  //   super.onTapUp(event);
  //   print('coucou');
  //   joystickWrapper.position = Vector2(0, 0);
  //   touchPosition = Vector2(0, 0);
  // }

  // @override
  // void onTapCancel(TapCancelEvent event) {
  //   super.onTapCancel(event);
  //   print('coucou');
  //   joystickWrapper.position = Vector2(0, 0);
  //   touchPosition = Vector2(0, 0);
  // }
}
