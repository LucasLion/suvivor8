import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:suvivor8/constants.dart';
import 'package:suvivor8/game/survivor8_game.dart';

class Bullet extends SpriteComponent with HasGameRef<Survivor8Game> {
  late SpriteSheet spriteSheet;

  Bullet(Vector2 position) : super(position: position, size: Vector2(500, 500)) {}

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await loadSpriteSheet();
  }

  @override
  void update(double dt) {
    super.update(dt);
    print("bullet position: $position");
    position.add(position);
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

