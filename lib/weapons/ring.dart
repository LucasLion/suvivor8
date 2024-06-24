import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:flame/components.dart';
import 'package:suvivor8/settings.dart';

class Ring extends SpriteComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  final double startingPoint;
  late SpriteSheet spriteSheet;
  Vector2 playerPosition;
  double radius = 150;
  @override
  double angle = 0;
  double speed = 0.01;

  Ring(this.playerPosition, this.startingPoint)
      : super(
          size: Vector2(16, 16),
          // position: playerPosition,
        ) {
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = playerPosition + Vector2.all(radius + startingPoint);
    spriteSheet = SpriteSheet(
      image: await gameRef.images.load(fireRing),
      srcSize: Vector2(16, 16),
    );
    sprite = spriteSheet.getSprite(2, 34);
    scale = Vector2(2, 2);
    final hitboxSize = Vector2(14, 14);
    final hitboxPosition = (size - hitboxSize) / 2;
    final hitbox = RectangleHitbox(
      size: hitboxSize,
      position: hitboxPosition,
      collisionType: CollisionType.passive,
    );
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += speed * dt * 400;
    position =
        playerPosition + Vector2(radius * cos(angle + startingPoint), radius * sin(angle + startingPoint));
  }
}
