import 'package:flutter/material.dart';

class BattleScreen extends StatefulWidget {
  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late int playerAttack;
  late int playerDefense;
  late int enemyAttack;
  late int enemyDefense;
  late bool playerFirst;

  String playerImage = 'assets/images/stickman2.png';
  String enemyImage = 'assets/images/stickman2.png';

  int playerHealth = 10;
  int enemyHealth = 10;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    playerAttack = args['playerAttack'] ?? 0;
    playerDefense = args['playerDefense'] ?? playerAttack;
    enemyAttack = args['enemyAttack'] ?? 0;
    enemyDefense = args['enemyDefense'] ?? enemyAttack;

    // Use provided health points or default to 10
    playerHealth = args['playerHealth'] ?? 10;
    enemyHealth = args['enemyHealth'] ?? 10;

    playerFirst = args['playerFirst'] ?? true;

    _startBattle();
  }

  void _startBattle() async {
    if (playerFirst) {
      await _performAction("You", playerAttack, enemyDefense);

      if (enemyHealth > 0) {
        await _performAction("Enemy", enemyAttack, playerDefense);
      }
    } else {
      await _performAction("Enemy", enemyAttack, playerDefense);

      if (playerHealth > 0) {
        await _performAction("You", playerAttack, enemyDefense);
      }
    }

    if (playerHealth <= 0) {
      Navigator.pushReplacementNamed(context, '/lose');
    } else if (enemyHealth <= 0) {
      Navigator.pushReplacementNamed(context, '/win');
    }
  }

  Future<void> _performAction(String actor, int attack, int defense) async {
    setState(() {
      if (actor == "You") {
        playerImage = 'assets/images/stickman0.png'; // Attack image for player
        int damage = attack > defense ? attack - defense : 0;
        enemyHealth -= damage;
      } else if (actor == "Enemy") {
        enemyImage = 'assets/images/stickman1.png'; // Attack image for enemy
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
        title: Text('Hoki Lu Kocak'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loginPageImage.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hoki Lu Kocak',
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Player Column
                    Column(
                      children: [
                        Image.asset(playerImage, width: 100, height: 100),
                        Text('You',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Health: $playerHealth',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    // Enemy Column
                    Column(
                      children: [
                        Image.asset(enemyImage, width: 100, height: 100),
                        Text('Enemy',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Health: $enemyHealth',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/dice-roll',
                        arguments: {
                          'playerHealth': playerHealth,
                          'enemyHealth': enemyHealth,
                          'botName': 'Bot',
                          'playerStarts': playerFirst,
                          'continueGame':
                              true // Add a flag to indicate ongoing game
                        });
                  },
                  child: Text("Roll Again"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
