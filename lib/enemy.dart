import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/bullet.dart';
import 'package:suvivor8/constants.dart';
import 'package:suvivor8/game/survivor8_game.dart';

class Enemy extends SpriteAnimationComponent with HasGameRef<Survivor8Game>, CollisionCallbacks {
  final Vector2 pos;
  late SpriteAnimation animationIdleFrontRight;
  late SpriteAnimation animationIdleFrontLeft;
  late SpriteAnimation animationIdleBackRight;
  late SpriteAnimation animationIdleBackLeft;
  late SpriteAnimation animationWalkFrontRight;
  late SpriteAnimation animationWalkFrontLeft;
  late SpriteAnimation animationWalkBackRight;
  late SpriteAnimation animationWalkBackLeft;

  Enemy(this.pos) : super(size: Vector2(32, 32), position: Vector2(pos.x, pos.y));

  @override
  void onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
    animationWalkFrontRight =
        await animate(spriteSheetSlimeIdle, 0, 0, 32, 0.3);
    animationWalkFrontLeft = await animate(spriteSheetSlimeIdle, 1, 0, 32, 0.3);
    animationWalkBackRight = await animate(spriteSheetSlimeIdle, 2, 0, 32, 0.3);
    animationWalkBackLeft = await animate(spriteSheetSlimeIdle, 3, 0, 32, 0.3);

    animation = animationWalkFrontRight;
    size = Vector2(200, 200);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    move(dt);
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

  void move(double dt) {
    final player = gameRef.world.player;
    final diff = player.position - position;
    final diffNormalized = diff.normalized();
    const speed = 8.0;
    position += diffNormalized * speed * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet) {
      removeFromParent();
      other.removeFromParent();
    }
  }
}
