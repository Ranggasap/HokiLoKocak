import 'package:flutter/foundation.dart';

class GameState extends ChangeNotifier {
  int _playerHealth = 10;
  int _enemyHealth = 10;
  bool _playerFirst = true;

  int get playerHealth => _playerHealth;
  int get enemyHealth => _enemyHealth;
  bool get playerFirst => _playerFirst;

  void updateHealthAndTurn(
      int playerHealth, int enemyHealth, bool playerFirst) {
    _playerHealth = playerHealth;
    _enemyHealth = enemyHealth;
    _playerFirst = playerFirst;
    notifyListeners();
  }

  void resetGame() {
    _playerHealth = 10;
    _enemyHealth = 10;
    _playerFirst = true;
    notifyListeners();
  }
}
