import 'package:flutter/material.dart';
import 'package:hoki_lo_kocak/Services/DatabaseService.dart';

class WinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the arguments if passed
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Retrieve data with fallback to default values if arguments are null
    final String email = args?['email'] ?? 'unknown';
    final int win = args?['win'] ?? 0;
    final int lose = args?['lose'] ?? 0;
    final double winrate = args?['winrate'] ?? 0.0;
    final int rank = args?['rank'] ?? 0;

    // Tambahkan metode untuk mengelola leaderboard
    Future<void> handleLeaderboardUpdate() async {
      final DatabaseService databaseService = DatabaseService();

      try {
        // Cek apakah pemain sudah ada di leaderboard
        final existingPlayer = await databaseService.getPlayerByEmail(email);

        if (existingPlayer == null) {
          // Jika pemain belum ada, tambahkan ke leaderboard
          await databaseService.addPlayer(email, win + 1, lose, winrate, rank.toString());
          print('Player added to leaderboard.');
        } else {
          // Jika pemain sudah ada, perbarui data
          final newWin = (existingPlayer['win'] as int) + 1;
          final newLose = existingPlayer['lose'] as int;
          final newWinrate = (newWin / (newWin + newLose));
          final newRank = rank; // Gunakan logika rank sesuai kebutuhan

          await databaseService.updatePlayerByEmail(email, {
            'win': newWin,
            'lose': newLose,
            'winrate': newWinrate,
            'rank': newRank.toString(),
          });
          print('Player updated in leaderboard.');
        }
      } catch (e) {
        print('Error updating leaderboard: $e');
      }
    }

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
                  Icons.sentiment_very_satisfied,
                  size: 100,
                  color: Colors.greenAccent,
                ),
                SizedBox(height: 20),
                Text(
                  'Selamat! Kamu Menang! 🎉',
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.greenAccent,
                    elevation: 10,
                    shadowColor: Colors.green,
                  ),
                  onPressed: () async {
                    // Panggil metode untuk mengelola leaderboard
                    await handleLeaderboardUpdate();

                    // Navigasi ke halaman utama
                    Navigator.pushReplacementNamed(
                      context,
                      '/mainpage',
                      arguments: {
                        'email': email,
                        'win': win + 1,
                        'lose': lose,
                        'winrate': winrate,
                        'rank': rank,
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
