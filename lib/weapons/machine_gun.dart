import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/game/settings.dart';
import 'package:suvivor8/weapons/bullet.dart';
import 'package:suvivor8/weapons/weapon.dart';

class MachineGun extends Weapon {
  late Vector2 dir;
  late double timer = 0.0;
  late RectangleHitbox bulletHitbox;
  late Vector2 lastDir;
  late Sprite sprite;
  late SpriteSheet spriteSheet;
  double coolDown = 1.2;
  BulletMoveType moveType = BulletMoveType.straight;

  MachineGun(Vector2 position, this.dir, double shootSpeed, int numberOfBullets)
      : super(position, dir, shootSpeed) {
    anchor = Anchor.center;
    position = Vector2(position.x, position.y);
  }

  void updateLast(Vector2 newLast, Vector2 pos) {
    dir = newLast;
    position = Vector2(pos.x, pos.y);
  }

  void upgrade(String type) {
    if (type == 'shootSpeed' && coolDown > 0.2) {
      coolDown -= 0.1;
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final image = await gameRef.images.load(bulletsYellow);
    spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(16, 16),
    );
    sprite = spriteSheet.getSprite(2, 11);
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer += dt;
    if (timer >= coolDown) {
      _shoot(dt);
      timer = 0.0;
    }
  }

  void _shoot(double dt) {
    final bullet = Bullet(position, dir, sprite, moveType, 0, 1);
    gameRef.world.add(bullet);
  }
}
