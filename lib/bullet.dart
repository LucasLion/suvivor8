
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/constants.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  late SpriteSheet spriteSheet;
  late Vector2 direction;

  Bullet(Vector2 position, this.direction)
      : super(
          position: Vector2(position.x, position.y),
          size: Vector2(32, 32),
        ) {
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(
        position.x,  position.y);
    final hitboxSize = Vector2(8, 8);
    final hitboxPosition = (size - hitboxSize) / 2;
    final hitbox = RectangleHitbox(
      size: hitboxSize,
      position: hitboxPosition,
      collisionType: CollisionType.passive,
    );
    add(hitbox);
    animation = await animate(bulletsYellow, 8, 11, 14, 0.03);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (position.x < 0 ||
        position.x > gameRef.size.x ||
        position.y < 0 ||
        position.y > gameRef.size.y) {
      removeFromParent();
    }
    position = position + direction * 400 * dt;
  }

  dynamic animate(String ss, int row, int from, int to, double stepTime) async {
    final image = await gameRef.images.load(ss);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(16),
    );
    return animation = spriteSheet.createAnimation(
        row: row, stepTime: stepTime, from: from, to: to);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Enemy) {
      removeFromParent();
      other.removeFromParent();
    }
  }

}
