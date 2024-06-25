import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/game/settings.dart';
import 'package:suvivor8/weapons/bullet.dart';
import 'package:suvivor8/weapons/weapon.dart';

class Ring extends Weapon {
  @override
  double angle = 0;
  final double startingPoint;
  Vector2 playerPosition;
  double radius = 150;
  double speed = 0.01;
  late SpriteSheet spriteSheet;
  late Sprite sprite;
  BulletMoveType moveType = BulletMoveType.spin;
  int numberOfRings = 1;
  double rotationSpeed = 1;
  List<Bullet> currentRings = [];

  Ring(this.playerPosition, this.startingPoint)
      : super(
          playerPosition,
          Vector2(1, 0),
          0.5,
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
    final Bullet ring =
        Bullet(playerPosition, size, sprite, moveType, 0, rotationSpeed);
    gameRef.world.add(ring);
    currentRings.add(ring);
  }

  void upgrade(String type) {
    if (type == 'rotationSpeed') {
      rotationSpeed += 1;
      currentRings.forEach((ring) {
        ring.rotationSpeed = rotationSpeed;
      });
    } else if (type == 'number') {
      int desiredNumberOfRings = numberOfRings + 1;
      double newAngleIncrement = (2 * pi) / desiredNumberOfRings;
      double radius = 100;

      currentRings.forEach((ring) {
        gameRef.world.remove(ring);
      });
      currentRings.clear();
      List<Bullet> newRings = [];
      for (int i = 0; i < desiredNumberOfRings; i++) {
        double angle = newAngleIncrement * i;
        Bullet newRing =
            Bullet(Vector2(x, y), size, sprite, moveType, angle, rotationSpeed);
        newRings.add(newRing);
      }
      newRings.forEach((newRing) {
        currentRings.add(newRing);
        gameRef.world.add(newRing);
      });
      numberOfRings = desiredNumberOfRings;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
