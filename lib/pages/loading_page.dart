
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 128,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              width: MediaQuery.of(context).size.width,
              child: const LinearProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}