import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/game/settings.dart';

class Bullet extends SpriteComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  late Vector2 direction;
  late RectangleHitbox hitbox;
  late BulletMoveType moveType;
  double radius = 150;
  double fullCircle = 2 * pi;
  double initialAngle;
  double rotationSpeed = 1.0;

  Bullet(Vector2 position, this.direction, Sprite sprite, this.moveType, this.initialAngle, this.rotationSpeed)
      : super(
          position: Vector2(position.x, position.y),
          sprite: sprite,
          size: Vector2(16, 16),
        ) {
    anchor = Anchor.center;
    scale = Vector2(2, 2);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    direction = direction;
    final hitboxSize = Vector2(8, 8);
    final hitboxPosition = (size - hitboxSize) / 2;
    hitbox = RectangleHitbox(
      size: hitboxSize,
      position: hitboxPosition,
      collisionType: CollisionType.passive,
    );
    add(hitbox);
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (moveType) {
      case BulletMoveType.straight:
        position = position + direction * bulletSpeed * dt;
        break;
      case BulletMoveType.spin:
        angle += dt * rotationSpeed;
        double currentAngle = initialAngle + rotationSpeed * dt;
        Vector2 playerPosition = gameRef.world.player.position;
        position = playerPosition + Vector2(radius * cos(angle + currentAngle), radius * sin(angle + currentAngle));
        break;
    }
  }
}
