import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/weapons/bullet.dart';
import 'package:suvivor8/settings.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/weapons/ring.dart';
import 'package:suvivor8/xp.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  final Vector2 pos;
  late SpriteAnimation animationIdleFrontRight;
  late SpriteAnimation animationIdleFrontLeft;
  late SpriteAnimation animationIdleBackRight;
  late SpriteAnimation animationIdleBackLeft;
  late SpriteAnimation animationWalkFrontRight;
  late SpriteAnimation animationWalkFrontLeft;
  late SpriteAnimation animationWalkBackRight;
  late SpriteAnimation animationWalkBackLeft;

  Enemy(this.pos)
      : super(
            size: Vector2(32, 32),
            position: Vector2(pos.x, pos.y),
            anchor: Anchor.center);

  @override
  void onLoad() async {
    super.onLoad();
    animationWalkFrontRight =
        await animate(spriteSheetSlimeIdle, 0, 0, 16, 0.3);
    // animationWalkFrontLeft = await animate(spriteSheetSlimeIdle, 1, 0, 16, 0.3);
    // animationWalkBackRight = await animate(spriteSheetSlimeIdle, 2, 0, 16, 0.3);
    // animationWalkBackLeft = await animate(spriteSheetSlimeIdle, 3, 0, 16, 0.3);

    final hitboxSize = Vector2(8, 6);
    final hitboxPosition = (size - hitboxSize) / 2;
    final hitbox = RectangleHitbox(
      size: hitboxSize,
      position: hitboxPosition,
    );
    add(hitbox);
    animation = animationWalkFrontRight;
    scale = Vector2(6, 6);
  }

  @override
  void update(double dt) {
    super.update(dt);
    move(dt);
  }

  dynamic animate(String ss, int row, int from, int to, double stepTime) async {
    final image = await gameRef.images.load(ss);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(32),
    );
    return animation = spriteSheet.createAnimation(
        row: row, stepTime: stepTime, from: from, to: to);
  }

  void move(double dt) {
    final playerPosition = gameRef.world.player.position;
    final diff = playerPosition - position;
    final diffNormalized = diff.normalized();
    const speed = 50.0;
    position += diffNormalized * speed * dt;
  }

  void die(other) {
    Xp xp = Xp(position);
    gameRef.add(xp);
    gameRef.world.xpList.add(xp);
    removeFromParent();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet || other is Ring) {
      die(other);
      enemies -= 1;
    }
    if (other is Enemy) {
      final diff = other.position - position;
      final diffNormalized = diff.normalized();
      position.x -= diffNormalized.x * 8;
      position.y -= diffNormalized.y * 6;
    }
  }
}
