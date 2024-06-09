import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/constants.dart';
import 'package:suvivor8/game/survivor8_game.dart';

class Bullet extends SpriteComponent with HasGameRef<Survivor8Game> {
  late SpriteSheet spriteSheet;

  Bullet(Vector2 position)
      : super(
          position: Vector2(position.x, position.y),
          size: Vector2(64, 64),
        ) {
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(
        position.x + gameRef.size.x / 2, position.y + gameRef.size.y / 2);
    await loadSpriteSheet();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = position + Vector2(1, 1) * 200 * dt;
  }

  Future<void> loadSpriteSheet() async {
    final image = await gameRef.images.load(bulletsYellow);
    spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2.all(16),
    );
    sprite = spriteSheet.getSprite(0, 11);
  }
}
