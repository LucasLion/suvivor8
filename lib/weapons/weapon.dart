import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';

class Weapon extends PositionComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  late SpriteSheet spriteSheet;
  late Vector2 direction;

  Weapon(
    Vector2 position,
    this.direction,
    this.spriteSheet,
  ) : super(
          position: Vector2(position.x, position.y),
          size: Vector2(32, 32),
        ) {
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(position.x, position.y);
    gameRef.world.add(this);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      removeFromParent();
    }
  }
}
