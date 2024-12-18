import 'package:flutter/material.dart';
import 'dart:async';

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};

    playerAttack = args['playerAttack'] ?? 0;
    enemyAttack = args['enemyAttack'] ?? 0;
    playerFirst = args['playerFirst'] ?? true;

    _startBattle();
  }

  // Method to start the battle automatically
  void _startBattle() async {
    // Player attacks first
    if (playerFirst) {
      await _performAction("You", playerAttack, enemyHealth, enemyDefense);

      // Check if the enemy is dead after player's attack
      if (enemyHealth <= 0) {
        Navigator.pushReplacementNamed(context, '/win'); // Player wins
        return;
      }
    } else {
      // Enemy attacks first
      await _performAction("Enemy", enemyAttack, playerHealth, playerDefense);

      // Check if the player is dead after enemy's attack
      if (playerHealth <= 0) {
        Navigator.pushReplacementNamed(context, '/lose'); // Player loses
        return;
      }
    }
  }

  // Perform attack action and update health
  Future<void> _performAction(
      String actor, int attack, int health, int defense) async {
    setState(() {
      // Calculate actual damage by subtracting defense from attack
      int actualDamage = (attack - defense);
      if (actualDamage < 0) actualDamage = 0; // Ensure no negative damage

      // Apply damage
      if (actor == "You") {
        playerImage = 'assets/images/stickman0.png'; // Player Attack Image
        enemyHealth -= actualDamage; // Decrease enemy health
      } else if (actor == "Enemy") {
        enemyImage = 'assets/images/stickman1.png'; // Enemy Attack Image
        playerHealth -= actualDamage; // Decrease player health
      }
    });

    // Wait for 2 seconds before resetting images
    await Future.delayed(const Duration(seconds: 2));

    // Reset images after attack
    setState(() {
      playerImage = 'assets/images/stickman2.png'; // Reset to default player image
      enemyImage = 'assets/images/stickman2.png'; // Reset to default enemy image
    });
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
          child: Container(
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
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
          ),
        ),
      ),
    );
  }
}
