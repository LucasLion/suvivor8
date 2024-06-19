import 'package:flutter/material.dart';

class LooseScreen extends StatefulWidget {
  const LooseScreen({super.key});

  @override
  LooseScreenState createState() => LooseScreenState();
}

class LooseScreenState extends State<LooseScreen> {
  late final ValueListenableBuilder<int> xpListener;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You loose!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 64,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
