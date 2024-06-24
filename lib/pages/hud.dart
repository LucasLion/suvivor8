
import 'package:flutter/material.dart';
import 'package:suvivor8/player.dart';

class Ath extends StatefulWidget {
  final Player player;
  const Ath({super.key, required this.player});

  @override
  AthState createState() => AthState();
}

class AthState extends State<Ath> {
  late final ValueListenableBuilder<int> xpListener;

  @override
  void initState() {
    super.initState();
    xpListener = ValueListenableBuilder<int>(
      valueListenable: widget.player.xpNotifier,
      builder: (context, value, child) {
        return Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 128,
          ),
        );
      },
    );
  }

  Widget xpBar() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        width: 1024,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(2),
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: widget.player.xpNotifier,
          builder: (context, xpValue, child) {
            return ValueListenableBuilder<int>(
              valueListenable: widget.player.maxXpNotifier,
              builder: (context, maxXpValue, child) {
                final percentage = (xpValue / maxXpValue).clamp(0.0, 1.0);
                return Row(
                  children: [
                    Container(
                      width: (percentage * 1020).round().toDouble(),
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget pauseButton() {
    return IconButton(
      icon: const Icon(Icons.pause),
      iconSize: 128,
      color: Colors.white,
      onPressed: () {
        if (widget.player.gameRef.paused) {
          widget.player.gameRef.resumeEngine();
        } else {
          widget.player.gameRef.pauseEngine();
        }
      },
    );
  }

  Widget level(TextStyle textStyle) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.player.levelNotifier,
      builder: (context, value, child) {
        return Container(
          padding: const EdgeInsets.only(left: 50.0),
          child: Text(
            'Level: $value',
            textAlign: TextAlign.left,
            style: textStyle,
          ),
        );
      },
    );
  }

  Widget lifeBar() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        width: 1024,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(2),
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: widget.player.lifeBarNotifier,
          builder: (context, value, child) {
            return Row(
              children: [
                Container(
                  width: (value * 10.2).round().toDouble(),
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget xp() {
    return xpListener;
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 64,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        xpBar(),
        lifeBar(),
        level(textStyle),
        pauseButton(),
        // xp(),
      ],
    );
  }
}
