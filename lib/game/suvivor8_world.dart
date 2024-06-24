import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
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
  late final GameJoystick joystick;
  late Vector2 joystickSize;
  late PositionComponent joystickWrapper;
  late Vector2 joystickPosition;
  late Vector2 touchPosition;
  late Image backgroundImage;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawImage(
        backgroundImage,
        Offset(-backgroundImage.width / 2, -backgroundImage.height / 2),
        Paint());
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final TiledComponent tiledComponent = await TiledComponent.load(
      'map.tmx',
      Vector2.all(worldScale),
    );

    await _drawBackground(tiledComponent);
    await _drawWalls(tiledComponent);
    gameRef.world.add(player);
    gameRef.camera.follow(player);
    gameRef.camera.setBounds(
      Polygon([
        Vector2(-backgroundImage.width / 2, -backgroundImage.height / 2),
        Vector2(backgroundImage.width / 2, -backgroundImage.height / 2),
        Vector2(backgroundImage.width / 2, backgroundImage.height / 2),
        Vector2(-backgroundImage.width / 2, backgroundImage.height / 2),
      ]),
    );

    game.overlays.remove('loading');
    game.overlays.add('joystick');
    game.overlays.add('hud');
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer += dt;
    if (timer >= spawnSpeed) {//} && enemies < 1150) {
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

  Future<void> _drawBackground(TiledComponent component) async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    component.render(canvas);
    final picture = recorder.endRecording();
    backgroundImage = await picture.toImage(
        (component.width).toInt(), (component.height).toInt());
  }

  Future<void> _drawWalls(TiledComponent component) async {
    // final walls = component.tileMap.getLayer<ObjectGroup>('walls');
    final houses = component.tileMap.getLayer<ObjectGroup>('houses');
    final SpriteSheet plainsSS = SpriteSheet(
      image: await gameRef.images.load(plainsTileset),
      srcSize: Vector2(8, 8),
    );
    final SpriteSheet townSS = SpriteSheet(
      image: await gameRef.images.load(townTileset),
      srcSize: Vector2(8, 8),
    );

    // for (var wall in walls!.objects) {
    //   Vector2 offsetPosition = Vector2(
    //     wall.x * 4 - backgroundImage.width / 2,
    //     wall.y * 4 - backgroundImage.height / 2,
    //   );
    //   switch (wall.type) {
    //     case 'wall':
    //       gameRef.world.add(WallComponent()
    //         ..position = offsetPosition
    //         ..width = wall.width * 4
    //         ..height = wall.height * 4
    //         ..debugMode = true
    //         ..sprite = plainsSS.getSprite(1, 14));
    //       break;
    //     case 'wood':
    //       gameRef.world.add(SpriteComponent()
    //         ..position = offsetPosition
    //         ..width = wall.x * 4
    //         ..height = wall.y * 4
    //         ..debugMode = true
    //         ..sprite = townSS.getSprite(19, 5)
    //         ..scale = Vector2(4, 4));
    //       break;
    //   }
    // }
    for (var obj in houses!.objects) {
      switch (obj.type) {
        case 'stop':
        //player.die();
      }
    }
  }
}
