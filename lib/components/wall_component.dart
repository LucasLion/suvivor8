import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:suvivor8/game/survivor8_game.dart';
import 'package:suvivor8/game/player.dart';

class WallComponent extends SpriteComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  WallComponent() {
    debugMode = true;
    add(RectangleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Player) {
      gameRef.world.player.acceleration = 0;
    }
  }
}
