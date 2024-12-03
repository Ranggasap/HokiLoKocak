import 'package:flutter/material.dart';

class BattleScreen extends StatefulWidget {
  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  String playerImage = 'assets/images/stickman2.png';
  String enemyImage = 'assets/images/stickman2.png';

  int playerHealth = 10;
  int enemyHealth = 10;

  void _performAction(String actor, String action) {
    setState(() {
      if (actor == "You") {
        if (action == "Attack") {
          playerImage = 'assets/images/stickman0.png'; // Attack image for left
          enemyHealth -= 2;
        } else if (action == "Defend") {
          playerImage = 'assets/images/stickman3.png'; // Defend image for left
        } else {
          playerImage = 'assets/images/stickman2.png'; // Default
        }
      } else if (actor == "Enemy") {
        if (action == "Attack") {
          enemyImage = 'assets/images/stickman1.png'; // Attack image for right
          playerHealth -= 2;
        } else if (action == "Defend") {
          enemyImage = 'assets/images/stickman4.png'; // Defend image for right
        } else {
          enemyImage = 'assets/images/stickman2.png'; // Default
        }
      }

      // Reset images to default after 1 second
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          playerImage = 'assets/images/stickman2.png';
          enemyImage = 'assets/images/stickman2.png';
        });
      });

      // Check win/lose condition
      if (playerHealth <= 0) {
        Navigator.pushReplacementNamed(context, '/lose');
      } else if (enemyHealth <= 0) {
        Navigator.pushReplacementNamed(context, '/win');
      }
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
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  _performAction("You", "Attack"),
                              child: Text("Attack"),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () =>
                                  _performAction("You", "Defend"),
                              child: Text("Defend"),
                            ),
                          ],
                        ),
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
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  _performAction("Enemy", "Attack"),
                              child: Text("Attack"),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () =>
                                  _performAction("Enemy", "Defend"),
                              child: Text("Defend"),
                            ),
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
