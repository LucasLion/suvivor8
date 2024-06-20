import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/settings.dart';
import 'package:suvivor8/game/survivor8_game.dart';

// class Bullet extends SpriteAnimationComponent
class Bullet extends SpriteComponent
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
    position = Vector2(position.x, position.y);

    spriteSheet = SpriteSheet(
      image: await gameRef.images.load(bulletsYellow),
      srcSize: Vector2(16, 16),
    );
    sprite = spriteSheet.getSprite(8, 11);
    gameRef.world.add(this);
    final hitboxSize = Vector2(8, 8);
    final hitboxPosition = (size - hitboxSize) / 2;
    final hitbox = RectangleHitbox(
      size: hitboxSize,
      position: hitboxPosition,
      collisionType: CollisionType.passive,
    );
    add(hitbox);
    //animation = await animate(bulletsYellow, 8, 11, 14, 0.03);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (position.x < gameRef.world.player.position.x - gameRef.size.x ||
        position.x > gameRef.size.x + gameRef.world.player.position.x ||
        position.y < gameRef.world.player.position.y - gameRef.size.y ||
        position.y > gameRef.size.y + gameRef.world.player.position.y) {
      removeFromParent();
    }
    position = position + direction * bulletSpeed * dt;
  }

  // dynamic animate(String ss, int row, int from, int to, double stepTime) async {
  //   final image = await gameRef.images.load(ss);
  //   final spriteSheet = SpriteSheet(
  //     image: image,
  //     srcSize: Vector2.all(16),
  //   );
  //   return animation = spriteSheet.createAnimation(
  //       row: row, stepTime: stepTime, from: from, to: to);
  // }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
  }
}
