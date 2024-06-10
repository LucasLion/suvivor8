import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/constants.dart';
import 'package:suvivor8/game/survivor8_game.dart';

class Enemy extends SpriteAnimationComponent with HasGameRef<Survivor8Game> {

  late SpriteAnimation animationIdleFrontRight;
  late SpriteAnimation animationIdleFrontLeft;
  late SpriteAnimation animationIdleBackRight;
  late SpriteAnimation animationIdleBackLeft;
  late SpriteAnimation animationWalkFrontRight;
  late SpriteAnimation animationWalkFrontLeft;
  late SpriteAnimation animationWalkBackRight;
  late SpriteAnimation animationWalkBackLeft;

  Enemy() : super(size: Vector2(32, 32), position: Vector2(110, 110));

  @override
  void onLoad() async {
    super.onLoad();

    animationWalkFrontRight = await animate(spriteSheetSlimeIdle, 0, 0, 32, 0.3);
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


}