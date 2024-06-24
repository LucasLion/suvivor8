import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/settings.dart';
import 'package:suvivor8/weapons/bullet.dart';
import 'package:suvivor8/weapons/weapon.dart';

class MachineGun extends Weapon {
  late Vector2 dir;
  late double timer = 0.0;
  late RectangleHitbox bulletHitbox;
  late Vector2 lastDir;
  late Sprite sprite;

  MachineGun(Vector2 position, SpriteSheet spriteSheet, this.dir)
      : super(position, dir, spriteSheet) {
    anchor = Anchor.center;
    position = Vector2(position.x, position.y);
  }

  void updateLast(Vector2 newLast, Vector2 pos) {
    dir = newLast;
    position = Vector2(pos.x, pos.y);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = spriteSheet.getSprite(2, 11);
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer += dt;
    if (timer >= shootSpeed) {
      _shoot(dt);
      timer = 0.0;
    }
  }

  void _shoot(double dt) {
    final bullet = Bullet(position, dir, sprite);
    gameRef.world.add(bullet);
  }
}
