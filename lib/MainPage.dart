import 'package:flutter/material.dart';
import 'package:hoki_lo_kocak/Components/TableLeaderboardUI.dart';
import 'package:hoki_lo_kocak/Services/DatabaseService.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  final DatabaseService _databaseService = DatabaseService();
  List<Map<String, dynamic>> _leaderboardData = [];
  bool _isLoading = true;

  @override void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchLeaderboard(); // Fetch data setiap kali halaman muncul kembali
  }

  Future<void> _fetchLeaderboard() async {
    final data = await _databaseService.fetchLeaderboard();
    setState(() {
      _leaderboardData = data.map((player) {
        final winrate = (player['winrate'] ?? 0.0) * 100;
        return {
          'email': player['email'],
          'win': player['win'].toString(), // Pastikan tipe data menjadi String
          'lose': player['lose'].toString(), // Sama untuk lose
          'winrate': winrate.toStringAsFixed(2), // Format double menjadi String
          'rank': player['rank'].toString(), // Sama untuk rank
        };
      }).toList();
      _isLoading = false;
      print("Loading data");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : TableLeaderboardUI(leaderboardData: _leaderboardData),
    );
  }
}
