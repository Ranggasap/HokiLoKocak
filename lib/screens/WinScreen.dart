import 'package:flutter/material.dart';

class WinScreen extends StatelessWidget {
  final String email;
  final int win;
  final int lose;
  final double winrate;
  final int rank;

  WinScreen({
    required this.email,
    required this.win,
    required this.lose,
    required this.winrate,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Icon(
                  Icons.sentiment_very_satisfied,
                  size: 100,
                  color: Colors.greenAccent,
                ),
                SizedBox(height: 20),
                Text(
                  'Selamat, kamu menang! 🎉',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [Colors.green, Colors.blue],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                // Display the player's info (email, wins, losses, etc.)
                Column(
                  children: [
                    Text(
                      'Email: $email',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Wins: $win',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Losses: $lose',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Winrate: ${winrate.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Rank: $rank',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blueAccent,
                    elevation: 10,
                    shadowColor: Colors.greenAccent,
                  ),
                  onPressed: () {
                    // Navigate to Home or any other screen
                    Navigator.pushReplacementNamed(context, '/mainpage');
                  },
                  child: Text(
                    'Kembali ke Home',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
