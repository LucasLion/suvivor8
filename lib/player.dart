import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/bullet.dart';
import 'package:suvivor8/constants.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  double speedX = 0.0;
  double speedY = 0.0;
  final double acceleration = 150.0;
  final double maxSpeed = 150.0; // Vous pouvez ajuster cette valeur
  late Vector2 last;
  late double timer = 0.0;

  late SpriteAnimation animationIdleFrontRight;
  late SpriteAnimation animationIdleFrontLeft;
  late SpriteAnimation animationIdleBackRight;
  late SpriteAnimation animationIdleBackLeft;
  late SpriteAnimation animationWalkFrontRight;
  late SpriteAnimation animationWalkFrontLeft;
  late SpriteAnimation animationWalkBackRight;
  late SpriteAnimation animationWalkBackLeft;

  Player({
    required Function(double, double) onMove,
  }) : super(
          size: Vector2(200, 200),
          position: Vector2(0, 0),
        );

  @override
  void onLoad() async {
    super.onLoad();

    animationIdleFrontRight =
        await animate(spriteSheetHumanIdle, 0, 0, 16, 0.1);
    animationIdleFrontLeft = await animate(spriteSheetHumanIdle, 1, 0, 16, 0.1);
    animationIdleBackRight = await animate(spriteSheetHumanIdle, 2, 0, 16, 0.1);
    animationIdleBackLeft = await animate(spriteSheetHumanIdle, 3, 0, 16, 0.1);
    animationWalkFrontRight = await animate(spriteSheetHumanWalk, 0, 0, 4, 0.1);
    animationWalkFrontLeft = await animate(spriteSheetHumanWalk, 1, 0, 4, 0.1);
    animationWalkBackRight = await animate(spriteSheetHumanWalk, 2, 0, 4, 0.1);
    animationWalkBackLeft = await animate(spriteSheetHumanWalk, 3, 0, 4, 0.1);

    animation = animationIdleFrontRight;

    anchor = Anchor.center;
    last = Vector2(0, 1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(Vector2(speedX * dt, speedY * dt));
    timer += dt;
    if (timer >= .2) {
      shoot();
      timer = 0.0;
    }
  }

  void move(double deltaX, double deltaY) {
    Vector2 direction = Vector2(deltaX, deltaY);
    double magnitude = direction.length;
    if (deltaX != 0 || deltaY != 0) {
      last = direction.normalized();
    }
    if (!direction.isZero()) {
      direction.normalize();
      double baseSpeed = acceleration * magnitude;
      speedX = direction.x * min(baseSpeed, maxSpeed);
      speedY = direction.y * min(baseSpeed, maxSpeed);
      if (direction.y > 0) {
        if (direction.x > 0) {
          animation = animationWalkFrontRight;
        } else {
          animation = animationWalkFrontLeft;
        }
      } else {
        if (direction.x > 0) {
          animation = animationWalkBackRight;
        } else {
          animation = animationWalkBackLeft;
        }
      }
    } else {
      speedX *= min(0, acceleration);
      speedY *= min(0, acceleration);

      if (animation == animationWalkFrontRight) {
        animation = animationIdleFrontRight;
      } else if (animation == animationWalkFrontLeft) {
        animation = animationIdleFrontLeft;
      } else if (animation == animationWalkBackRight) {
        animation = animationIdleBackRight;
      } else if (animation == animationWalkBackLeft) {
        animation = animationIdleBackLeft;
      }
    }
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

  Bullet shoot() {
    gameRef.add(Bullet(position, last));
    return Bullet(position, last);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Enemy) {
      other.removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Dessiner la boîte de collision
    final debugPaint = Paint()
      ..color = Colors.red // Rouge
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final hitbox = RectangleHitbox(anchor: Anchor.topLeft, size: size);
    canvas.drawRect(hitbox.toRect(), debugPaint);
  }
}
