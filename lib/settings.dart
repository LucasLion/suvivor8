import 'dart:math';

const double gameWidth = 1080.0;
const double gameHeight = 1920.0;
const double worldScale = 32.0;
const double mapSize = 2000.0;
const double levelUpSpeed = 1.1;
double spawnSpeed = 1.0;
double bulletSpeed = 300.0;
double shootSpeed = 0.8;

int enemies = 0;

String spriteSheetHumanIdle =
    'creatures/Base_Humanoids/Human/Base_Human/HumanIdle.png';

String spriteSheetHumanWalk =
    'creatures/Base_Humanoids/Human/Base_Human/HumanWalk.png';

String spriteSheetDwarfIdle =
    'creatures/Base_Humanoids/Dwarf/Base_Dwarf/DwarfIdle.png';

String spriteSheetDwarfWalk =
    'creatures/Base_Humanoids/Dwarf/Base_Dwarf/DwarfWalk.png';

String spriteSheetSlimeIdle = 'creatures/Slimes/Green_Slime/SlimeGreenIdle.png';

String bulletsYellow = 'bullets/All_Fire_Bullet_Pixel_16x16_00.png';

String xpBlue = 'bullets/All_Fire_Bullet_Pixel_16x16_02.png';

List<int> levels =
    List<int>.generate(500, (i) => (7 * pow(levelUpSpeed, i)).round());
