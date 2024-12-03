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

  Future<void> addPlayer(String email, int win, int lose, double winrate, int rank) async {
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

  Future<void> updatePlayer(String docId, Map<String, dynamic> newData) async {
    try {
      await leaderboardCollection.doc(docId).update(newData);
    } catch (e) {
      print("Error updating player: $e");
    }
  }

  Future<void> deletePlayer(String docId) async {
    try {
      await leaderboardCollection.doc(docId).delete();
    } catch (e) {
      print("Error deleting player: $e");
    }
  }
}
