import 'package:flutter/material.dart';

class LoseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments if passed
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Retrieve data with fallback to default values if arguments are null
    final String email = args?['email'] ?? 'unknown'; // Default email if not passed
    final int win = args?['win'] ?? 0;  // Default win count
    final int lose = args?['lose'] ?? 0;  // Default lose count
    final double winrate = args?['winrate'] ?? 0.0;  // Default winrate
    final int rank = args?['rank'] ?? 0;  // Default rank

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sentiment_very_dissatisfied,
                  size: 100,
                  color: Colors.redAccent,
                ),
                SizedBox(height: 20),
                Text(
                  'Kalah yaaa wkwkw 🤣',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [Colors.red, Colors.blue],
                      ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  ),
                  textAlign: TextAlign.center,
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
                    shadowColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    // Navigate back to home and pass the necessary arguments
                    Navigator.pushReplacementNamed(
                      context,
                      '/mainpage',
                      arguments: {
                        'email': email,  // Pass the email
                        'win': win,      // Pass the win count
                        'lose': lose,    // Pass the lose count
                        'winrate': winrate,  // Pass the winrate
                        'rank': rank,    // Pass the rank
                      },
                    );
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
