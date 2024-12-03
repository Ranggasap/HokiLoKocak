import 'package:flutter/material.dart';

class BattleScreen extends StatefulWidget {
  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  // Gambar awal untuk pemain dan musuh
  String playerImage = 'assets/images/stickman2.png';
  String enemyImage = 'assets/images/stickman2.png';

  void _performAction(String actor, String action) {
    setState(() {
      if (actor == "You") {
        // Ubah gambar pemain berdasarkan tindakan
        if (action == "Attack") {
          playerImage = 'assets/images/stickman1.png';
        } else if (action == "Defend") {
          playerImage = 'assets/images/stickman3.png';
        }
      } else if (actor == "Enemy") {
        // Ubah gambar musuh berdasarkan tindakan
        if (action == "Attack") {
          enemyImage = 'assets/images/stickman1.png';
        } else if (action == "Defend") {
          enemyImage = 'assets/images/stickman3.png';
        }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Hoki Lu Kocak',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 0, 0),
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
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Player Column
                Column(
                  children: [
                    Image.asset(
                      playerImage, // Gambar pemain dinamis
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'You',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'The Attack : 2',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red),
                        SizedBox(width: 5),
                        Text(
                          '10',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => _performAction("You", "Attack"),
                          child: Text("Attack"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => _performAction("You", "Defend"),
                          child: Text("Defend"),
                        ),
                      ],
                    ),
                  ],
                ),
                // Enemy Column
                Column(
                  children: [
                    Image.asset(
                      enemyImage, // Gambar musuh dinamis
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Enemy',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '1 : The Defend',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red),
                        SizedBox(width: 5),
                        Text(
                          '10',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => _performAction("Enemy", "Attack"),
                          child: Text("Attack"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () => _performAction("Enemy", "Defend"),
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
    );
  }
}
