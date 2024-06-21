import 'package:flutter/material.dart';

class LevelUpPage extends StatefulWidget {
  const LevelUpPage({super.key});

  LevelUpPageState createState() => LevelUpPageState();
}

class LevelUpPageState extends State<LevelUpPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
          width: 200,
          height: 200,
          color: Colors.amber,
        ),
        Container(
          width: 200,
          height: 200,
          color: Colors.green,
        ),
        Container(
          width: 200,
          height: 200,
          color: Colors.blue,
        ),
      ]),
    );
  }
}
