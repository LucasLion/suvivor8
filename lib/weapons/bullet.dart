import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/settings.dart';

class Bullet extends SpriteComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  late Vector2 direction;
  late RectangleHitbox hitbox;

  Bullet(Vector2 position, this.direction, Sprite sprite)
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

    if (position.x < gameRef.world.player.position.x - gameRef.size.x ||
        position.x > gameRef.size.x + gameRef.world.player.position.x ||
        position.y < gameRef.world.player.position.y - gameRef.size.y ||
        position.y > gameRef.size.y + gameRef.world.player.position.y) {
      removeFromParent();
    }
    position = position + direction * bulletSpeed * dt;
  }
}
