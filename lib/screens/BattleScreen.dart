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
      // Jika player menyerang duluan
      await _performAction("You", playerAttack, enemyDefense,
          isDefending: false);

      // Langsung cek apakah enemy mati setelah diserang
      if (enemyHealth <= 0) {
        Navigator.pushReplacementNamed(context, '/win');
        return;
      }

      // Jika enemy masih hidup, maka enemy akan menyerang balik
      await _performAction("Enemy", enemyAttack, playerDefense,
          isDefending: false);

      // Cek apakah player mati setelah diserang enemy
      if (playerHealth <= 0) {
        Navigator.pushReplacementNamed(context, '/lose');
        return;
      }
    } else {
      // Jika enemy menyerang duluan
      await _performAction("Enemy", enemyAttack, playerDefense,
          isDefending: false);

      // Langsung cek apakah player mati setelah diserang
      if (playerHealth <= 0) {
        Navigator.pushReplacementNamed(context, '/lose');
        return;
      }

      // Jika player masih hidup, maka player akan menyerang balik
      await _performAction("You", playerAttack, enemyDefense,
          isDefending: false);

      // Cek apakah enemy mati setelah diserang player
      if (enemyHealth <= 0) {
        Navigator.pushReplacementNamed(context, '/win');
        return;
      }
    }
  }

  Future<void> _performAction(String actor, int attack, int defense,
      {required bool isDefending}) async {
    setState(() {
      if (actor == "You") {
        playerImage = isDefending
            ? 'assets/images/stickman3.png'
            : 'assets/images/stickman0.png';
        int damage = attack > defense ? attack - defense : 0;
        enemyHealth -= damage;
      } else if (actor == "Enemy") {
        enemyImage = isDefending
            ? 'assets/images/stickman4.png'
            : 'assets/images/stickman1.png';
        int damage = attack > defense ? attack - defense : 0;
        playerHealth -= damage;
      }
    });

    // Reset images to default after 1 second
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      playerImage = 'assets/images/stickman2.png';
      enemyImage = 'assets/images/stickman2.png';
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
