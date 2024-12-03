import 'package:flutter/material.dart';
import '../models/game_models.dart';

class PvPScreen extends StatefulWidget {
  @override
  _PvPScreenState createState() => _PvPScreenState();
}

class _PvPScreenState extends State<PvPScreen> {
  late Player playerOne;
  late Player botPlayer;
  late bool playerTurn;
  bool gameOver = false;
  String? winner;
  bool needDiceRoll = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    playerOne = args['playerOne'];
    botPlayer = args['botPlayer'];
    playerTurn = args['playerStarts'];
  }

  void _navigateToDiceRoll() {
    Navigator.pushReplacementNamed(context, '/dice-roll',
        arguments: {'botName': botPlayer.name, 'playerStarts': playerTurn});
  }

  void _checkGameStatus() {
    if (playerOne.healthPoints <= 0) {
      gameOver = true;
      winner = botPlayer.name;
    } else if (botPlayer.healthPoints <= 0) {
      gameOver = true;
      winner = playerOne.name;
    }
  }

  void _restartGame() {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PvP Battle'),
        centerTitle: true,
      ),
      body: gameOver ? _buildGameOverScreen() : _buildBattleScreen(),
    );
  }

  Widget _buildBattleScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPlayerStats(playerOne, 'Player'),
              _buildPlayerStats(botPlayer, botPlayer.name),
            ],
          ),
          SizedBox(height: 30),
          Text(
            playerTurn ? 'Your Turn' : '${botPlayer.name}\'s Turn',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          if (needDiceRoll)
            ElevatedButton(
              onPressed: _navigateToDiceRoll,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Roll Dice for Attack'),
            )
          else
            ElevatedButton(
              onPressed: _performAttack,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Attack'),
            )
        ],
      ),
    );
  }

  void _performAttack() {
    setState(() {
      if (playerTurn) {
        int damage = playerOne.currentDiceRoll;
        int defense = botPlayer.currentDefense;

        if (damage > defense) {
          botPlayer.takeDamage(damage);
        }
      } else {
        int damage = botPlayer.currentDiceRoll;
        int defense = playerOne.currentDefense;

        if (damage > defense) {
          playerOne.takeDamage(damage);
        }
      }

      _checkGameStatus();
      playerTurn = !playerTurn;
      needDiceRoll = true;
    });

    // Add a delay before navigating back to dice roll screen
    if (!gameOver) {
      Future.delayed(Duration(seconds: 3), () {
        _navigateToDiceRoll();
      });
    }
  }

  Widget _buildGameOverScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$winner Wins!',
            style: TextStyle(
                fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: _restartGame,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 18),
            ),
            child: Text('Play Again'),
          )
        ],
      ),
    );
  }

  Widget _buildPlayerStats(Player player, String label) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          width: 150,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                'HP: ${player.healthPoints}',
                style: TextStyle(
                    fontSize: 16,
                    color: player.healthPoints > 5 ? Colors.green : Colors.red),
              ),
              SizedBox(height: 10),
              Text(
                'Last Roll: ${player.currentDiceRoll}',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                'Last Defense: ${player.currentDefense}',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
