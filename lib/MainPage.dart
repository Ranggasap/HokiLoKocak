import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:hoki_lo_kocak/Components/TableLeaderboardUI.dart';
import 'package:hoki_lo_kocak/Services/AuthService.dart';
import 'package:hoki_lo_kocak/Services/DatabaseService.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  final DatabaseService _databaseService = DatabaseService();
  List<Map<String, dynamic>> _leaderboardData = [];
  bool _isLoading = true;

  final List<String> botNames = [
    'RoboWarrior',
    'CyberNinja',
    'MechHunter',
    'SteelStriker',
    'AlphaBot',
    'TechTitan',
    'ShadowDroid',
    'IronGuardian'
  ];

  @override
  void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    final data = await _databaseService.fetchLeaderboard();
    setState(() {
      _leaderboardData = data.map((player) {
        final winrate = (player['winrate'] ?? 0.0) * 100;
        return {
          'email': player['email'],
          'win': player['win'].toString(),
          'lose': player['lose'].toString(),
          'winrate': winrate.toStringAsFixed(2),
          'rank': player['rank'].toString(),
        };
      }).toList();
      _isLoading = false;
    });
  }

  String _generateRandomBotName() {
    final random = Random();
    return botNames[random.nextInt(botNames.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TableLeaderboardUI(
                    leaderboardData: _leaderboardData,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String botName = _generateRandomBotName();
                          Navigator.pushNamed(
                            context,
                            '/rock-paper-scissors',
                            arguments: botName,
                          );
                        },
                        child: Text('Start Game'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text('Logout'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
