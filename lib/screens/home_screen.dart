import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  final List<String> botNames = [
    'RoboWarrior',
    'CyberNinja',
    'MechHunter',
    'SteelStriker',
    'AlphaBot',
    'TechTitan',
    'ShadowDroid',
    'IronGuardian'
  ];

  String _generateRandomBotName() {
    final random = Random();
    return botNames[random.nextInt(botNames.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Battle PvP'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Dice Battle!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String botName = _generateRandomBotName();
                Navigator.pushNamed(context, '/rock-paper-scissors',
                    arguments: botName);
              },
              child: Text('Start Game'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
