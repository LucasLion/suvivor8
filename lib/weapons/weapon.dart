import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/game/enemy.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/game/settings.dart';

class Weapon extends PositionComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  late Vector2 direction;


  Weapon(
    Vector2 position,
    this.direction,
    shootSpeed,
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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Enemy) {
      removeFromParent();
    }
  }
}
