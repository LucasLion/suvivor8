import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:suvivor8/weapons/machine_gun.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/settings.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/weapons/ring.dart';
import 'package:suvivor8/weapons/weapon.dart';
import 'package:suvivor8/xp.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  double speedX = 0.0;
  double speedY = 0.0;
  double acceleration = 150.0;
  final double maxSpeed = 150.0;
  late Vector2 last;
  late double timer = 0.0;
  ValueNotifier<int> xpNotifier = ValueNotifier<int>(0);
  ValueNotifier<int> levelNotifier = ValueNotifier<int>(10);
  ValueNotifier<int> maxXpNotifier = ValueNotifier<int>(levels[0]);
  ValueNotifier<int> lifeBarNotifier = ValueNotifier<int>(100);
  double magneticRadius = 50.0;
  final weapons = <Weapon>[];
  late List<Xp> xpList = [];
  late Set<Xp> xpToRemove = {};
  late MachineGun machineGun;

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
          size: Vector2(32, 32),
          position: Vector2(0, 0),
        );

  @override
  void onLoad() async {
    super.onLoad();

    // ---------------- ring -----------------
    // const numberOfRings = 8;
    // const fullCircle = 2 * pi;
    // for (var i = 0; i < numberOfRings; i++) {
    //   final startingPoint = fullCircle * i / numberOfRings;
    //   gameRef.world.add(Ring(position, startingPoint));
    // }

    // ---------------- animation -----------------
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

    // ---------------- hitbox -----------------
    final hitboxSize = Vector2(6, 6);
    final hitboxPosition = (size - hitboxSize) / 2;
    final hitbox = RectangleHitbox(
      size: hitboxSize,
      position: hitboxPosition,
    );
    add(hitbox);

    anchor = Anchor.center;
    last = Vector2(0, 1);
    scale = Vector2(4, 4);

    // ---------------- first weapon -----------------
    final image = await gameRef.images.load(bulletsYellow);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(16, 16),
    );
    machineGun = MachineGun(position, spriteSheet, last);
    weapons.add(machineGun);
    gameRef.world.add(machineGun);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // ---------------- movement -----------------
    position.add(Vector2(speedX * dt, speedY * dt));
    position = Vector2(
      position.x.clamp(-gameRef.world.backgroundImage.width / 2 + size.x,
          gameRef.world.backgroundImage.height / 2 - size.y),
      position.y.clamp(-gameRef.world.backgroundImage.width / 2 + size.y,
          gameRef.world.backgroundImage.height / 2 - size.y),
    );

    // ---------------- magnet -----------------
    xpList.removeWhere((xp) {
      if (xp.position.distanceTo(position) < magneticRadius) {
        final direction = (xp.position - position).normalized();
        xp.position -= direction * 400 * dt;
        if (xp.position.distanceTo(position) < size.x) {
          return true;
        }
      }
      return false;
    });

    // ---------------- level up -----------------
    if (xpNotifier.value >= levels[levelNotifier.value]) {
      levelUp();
    }

    // ---------------- remove xp -----------------
    xpToRemove.forEach((xp) {
      xp.removeFromParent();
      xpList.remove(xp);
    });
    xpToRemove.clear();
    // ---------------- Death -----------------
    if (lifeBarNotifier.value <= 0) {
      die();
    }
  }

  void move(double deltaX, double deltaY) {
    Vector2 direction = Vector2(deltaX, deltaY);
    double magnitude = direction.length;
    if (deltaX != 0 || deltaY != 0) {
      last = direction.normalized();
      machineGun.position = position;
      machineGun.dir = last;
      // machineGun.updateLast(last, position);
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

  // Future<MachineGun> shoot() async {
  //   final image = await gameRef.images.load(bulletsYellow);
  //   final ss = SpriteSheet(
  //     image: image,
  //     srcSize: Vector2(16, 16),
  //   );
  //   gameRef.world.add(MachineGun(position, ss, last));
  //   return MachineGun(position, ss, last);
  // }

  void levelUp() {
    levelNotifier.value += 1;
    maxXpNotifier.value = levels[levelNotifier.value];
    xpNotifier.value = 0;
    magneticRadius += 20;
    spawnSpeed *= 0.75;
    bulletSpeed *= bulletSpeed > 600 ? 1.1 : 1;
    shootSpeed *= shootSpeed > 0.1 ? 0.8 : 1;
    //game.overlays.add('levelUp');
  }

  void die() {
    removeFromParent();
    // pause engine
    gameRef.pauseEngine();
    game.overlays.remove('joystick');
    game.overlays.add('gameOver');
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Xp) {
      other.removeFromParent();
      // xpList.remove(other);
      xpToRemove.add(other);
      xpNotifier.value += 10;
    }
    if (other is Enemy) {
      lifeBarNotifier.value -= lifeBarNotifier.value > 0 ? 10 : 0;
    }
  }
}
