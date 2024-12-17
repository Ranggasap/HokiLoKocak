import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get leaderboardCollection =>
      _firestore.collection('leaderboard');

  Future<List<Map<String, dynamic>>> fetchLeaderboard() async {
    try {
      final snapshot = await leaderboardCollection.orderBy('rank').get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching leaderboard data: $e");
      return [];
    }
  }

  Future<void> addPlayer(String email, int win, int lose, double winrate, String rank) async {
    try {
      await leaderboardCollection.add({
        'email': email,
        'win': win,
        'lose': lose,
        'winrate': winrate,
        'rank': rank,
      });
    } catch (e) {
      print("Error adding player: $e");
    }
  }

  Future<void> updatePlayerByEmail(String email, Map<String, dynamic> newData) async {
    try {
      final snapshot = await leaderboardCollection.where('email', isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs.first.id; // Ambil docId dokumen pertama yang cocok
        await leaderboardCollection.doc(docId).update(newData);
        print("Player with email $email updated successfully.");
      } else {
        print("No player found with email: $email");
      }
    } catch (e) {
      print("Error updating player with email $email: $e");
    }
  }

  Future<void> deletePlayerByEmail(String email) async {
    try {
      final snapshot = await leaderboardCollection.where('email', isEqualTo: email).get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs.first.id; // Ambil docId dokumen pertama yang cocok
        await leaderboardCollection.doc(docId).delete();
        print("Player with email $email deleted successfully.");
      } else {
        print("No player found with email: $email");
      }
    } catch (e) {
      print("Error deleting player with email $email: $e");
    }
  }
}
