import 'package:flutter/material.dart';
import 'dart:math';
import '../models/game_models.dart';

class RockPaperScissorsScreen extends StatefulWidget {
  @override
  _RockPaperScissorsScreenState createState() =>
      _RockPaperScissorsScreenState();
}

class _RockPaperScissorsScreenState extends State<RockPaperScissorsScreen> {
  GameChoice? playerChoice;
  GameChoice? botChoice;
  String? botName;
  bool gameFinished = false;

  final Color primaryRedColor = Color(0xFFE53935);
  final Color lightRedColor = Color(0xFFEF5350);
  final Color darkRedColor = Color(0xFFB71C1C);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    botName = ModalRoute.of(context)!.settings.arguments as String;
  }

  void _playRockPaperScissors(GameChoice choice) {
    setState(() {
      playerChoice = choice;
      botChoice = GameChoice.values[Random().nextInt(3)];
      gameFinished = true;
    });
  }

  bool _didPlayerWin() {
    if (playerChoice == botChoice) return false;

    switch (playerChoice!) {
      case GameChoice.rock:
        return botChoice == GameChoice.scissors;
      case GameChoice.paper:
        return botChoice == GameChoice.rock;
      case GameChoice.scissors:
        return botChoice == GameChoice.paper;
    }
  }

  void _navigateToDiceRoll() {
    if (playerChoice == botChoice) {
      // Jika draw, reset pemilihan
      setState(() {
        playerChoice = null;
        botChoice = null;
        gameFinished = false;
      });
      return;
    }

    // Pass playerStarts as true if the player won, false if lost
    Navigator.pushReplacementNamed(context, '/dice-roll',
        arguments: {'botName': botName, 'playerStarts': _didPlayerWin()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkRedColor.withOpacity(0.1),
      appBar: AppBar(
        title: Text(
          'Rock Paper Scissors',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: primaryRedColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              darkRedColor.withOpacity(0.2),
              lightRedColor.withOpacity(0.2)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose Your Move Against $botName',
                style: TextStyle(
                    fontSize: 20,
                    color: primaryRedColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildChoiceButton(GameChoice.rock, Icons.back_hand),
                  SizedBox(width: 20),
                  _buildChoiceButton(GameChoice.paper, Icons.front_hand),
                  SizedBox(width: 20),
                  _buildChoiceButton(GameChoice.scissors, Icons.cut),
                ],
              ),
              SizedBox(height: 30),
              if (gameFinished)
                Column(
                  children: [
                    Text(
                      _didPlayerWin()
                          ? 'You Won the Round!'
                          : (playerChoice == botChoice
                              ? 'Draw! Try Again.'
                              : 'You Lost the Round!'),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _didPlayerWin()
                            ? Colors.green
                            : (playerChoice == botChoice
                                ? Colors.blue
                                : primaryRedColor),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _navigateToDiceRoll,
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: primaryRedColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        playerChoice == botChoice
                            ? 'Play Again'
                            : 'Next: Dice Roll',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceButton(GameChoice choice, IconData icon) {
    return ElevatedButton(
      onPressed: gameFinished ? null : () => _playRockPaperScissors(choice),
      child: Icon(icon, size: 50, color: Colors.white),
      style: ElevatedButton.styleFrom(
        foregroundColor: lightRedColor,
        backgroundColor: primaryRedColor,
        padding: EdgeInsets.all(20),
        shape: CircleBorder(),
      ),
    );
  }
}
