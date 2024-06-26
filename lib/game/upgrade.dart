import 'package:flutter/material.dart';

class Upgrade {
  final String id;
  final String name;
  final String description;
  final Function action;
  final AssetImage image;

  Upgrade(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.action});
}

List<Upgrade> upgrades = [
  Upgrade(
    id: 'shootSpeed (machineGun)',
    name: 'Shoot Speed',
    description: 'Increase the speed of the bullets',
    image: const AssetImage('assets/images/weapons/machine-gun.png'),
    action: (game) {
      game.world.player.machineGun.upgrade('shootSpeed');
    },
  ),
  Upgrade(
    id: 'number (rings)',
    name: 'Number of Rings',
    description: 'Increase the number of rings (max 8)',
    image: const AssetImage('assets/images/weapons/ring-of-fire.png'),
    action: (game) {
      game.world.player.ring.upgrade('number');
    },
  ),
  Upgrade(
      id: 'shootSpeed (rings)',
      name: 'shoot Speed Rings',
      description: 'Increase the speed of the rings',
      image: const AssetImage('assets/images/weapons/ring-of-fire.png'),
      action: (game) {
        game.world.player.ring.upgrade('rotationSpeed');
      }),
  Upgrade(
      id: 'magnet',
      name: 'magnet',
      description: 'Increase the magnet range',
      image: const AssetImage('assets/images/weapons/magnet.png'),
      action: (game) {
        game.world.player.magneticRadius += 10;
      })
];
