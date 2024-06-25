import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/game/settings.dart';
import 'package:suvivor8/game/survivor8_game.dart';

class Xp extends SpriteComponent
    with HasGameRef<Survivor8Game>, CollisionCallbacks {
  final Vector2 pos;

  Xp(this.pos) : super(size: Vector2(16, 16)) {
    position.setFrom(pos);
    anchor = Anchor.center;
  }


  @override
  void onLoad() async {
    super.onLoad();
    final image = await gameRef.images.load(xpBlue);
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(16, 16),
    );
    sprite = spriteSheet.getSprite(5, 11);
    gameRef.world.add(this);

    final hitboxSize = Vector2(32, 32);
    final hitboxPosition = (size - hitboxSize) / 2;
    final hitbox = RectangleHitbox(
      size: hitboxSize,
      position: hitboxPosition,
      collisionType: CollisionType.passive,
    );
    add(hitbox);
    scale = Vector2(2, 2);
  }
  
}
