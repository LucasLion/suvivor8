import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/constants.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';

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
    add(RectangleHitbox());
    position = Vector2(
        position.x + gameRef.size.x / 2, position.y + gameRef.size.y / 2);
    await loadSpriteSheet();
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

  Future<void> loadSpriteSheet() async {
    final image = await gameRef.images.load(bulletsYellow);
    spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(16),
    );
    sprite = spriteSheet.getSprite(0, 11);
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
