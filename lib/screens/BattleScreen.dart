import 'package:flutter/material.dart';
import 'package:hoki_lo_kocak/screens/LoseScreen.dart';
import 'dart:async';

import 'package:hoki_lo_kocak/screens/WinScreen.dart';

class BattleScreen extends StatefulWidget {
  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late int playerAttack;
  late int enemyAttack;
  late bool playerFirst;

  String playerImage = 'assets/images/stickman2.png'; // Default Player Image
  String enemyImage = 'assets/images/stickman2.png'; // Default Enemy Image

  int playerHealth = 3;
  int enemyHealth = 3;
  int playerDefense = 1; // Player defense value
  int enemyDefense = 1; // Enemy defense value

  String? battleResult; // null, 'win', or 'lose'

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    playerAttack = args['playerAttack'] ?? 0;
    playerDefense = args['playerDefense'] ?? playerAttack;
    enemyAttack = args['enemyAttack'] ?? 0;
    enemyDefense = args['enemyDefense'] ?? enemyAttack;

    playerHealth = args['playerHealth'] ?? 3;
    enemyHealth = args['enemyHealth'] ?? 3;

    playerFirst = args['playerFirst'] ?? true;

    _startBattle();
  }

  void _startBattle() async {
  if (playerFirst) {
    await _performAction("You", playerAttack, enemyDefense);
    if (enemyHealth <= 0) {
      setState(() => battleResult = 'win');
      _navigateToResult();
      return;
    }
    await _performAction("Enemy", enemyAttack, playerDefense);
    if (playerHealth <= 0) {
      setState(() => battleResult = 'lose');
      _navigateToResult();
      return;
    }
  } else {
    await _performAction("Enemy", enemyAttack, playerDefense);
    if (playerHealth <= 0) {
      setState(() => battleResult = 'lose');
      _navigateToResult();
      return;
    }
    await _performAction("You", playerAttack, enemyDefense);
    if (enemyHealth <= 0) {
      setState(() => battleResult = 'win');
      _navigateToResult();
      return;
    }
  }
}

Future<void> _performAction(String actor, int attack, int defense) async {
  // Update the image for the action.
  setState(() {
    if (actor == "You") {
      playerImage = 'assets/images/stickman0.png'; // Update player image for action
      int damage = attack > defense ? attack - defense : 0;
      enemyHealth -= damage;
    } else if (actor == "Enemy") {
      enemyImage = 'assets/images/stickman1.png'; // Update enemy image for action
      int damage = attack > defense ? attack - defense : 0;
      playerHealth -= damage;
    }
  });

  await Future.delayed(Duration(seconds: 1)); // Simulate action delay

  setState(() {
    // Reset player and enemy images after action
    playerImage = 'assets/images/stickman2.png';
    enemyImage = 'assets/images/stickman2.png';
  });
}

Future<void> _navigateToResult() async {
  // Use a delay before navigating to the result screen
  await Future.delayed(Duration(seconds: 1)); // Delay to simulate battle ending

  // Ensure that the navigation works correctly
  if (battleResult != null) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => battleResult == 'win' ? WinScreen() : LoseScreen(),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battle Time!'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loginPageImage.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: battleResult == null
              ? _buildBattleView()
              : _buildResultView(), // Switch between battle and result views
        ),
      ),
    );
  }

  Widget _buildBattleView() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Battle Time!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.red,
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(playerImage, width: 100, height: 100),
                  const Text('You',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red, size: 20),
                      Text(' HP: $playerHealth',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Image.asset(enemyImage, width: 100, height: 100),
                  const Text('Enemy',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red, size: 20),
                      Text(' HP: $enemyHealth',
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          battleResult == 'win' ? 'You Win!' : 'You Lose!',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            print('Navigating to ${battleResult == 'win' ? '/win' : '/lose'}');
            // Menavigasi ke halaman kemenangan atau kekalahan
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => battleResult == 'win' ? WinScreen() : LoseScreen(),
              ),
            );
          },
          child: Text(battleResult == 'win' ? 'Go to Win Screen' : 'Go to Lose Screen'),
        ),
      ],
    );
  }
}
