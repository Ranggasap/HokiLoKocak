enum GameChoice { rock, paper, scissors }

class Player {
  String name;
  int healthPoints;
  int currentDiceRoll;
  int currentDefense;

  Player(
      {required this.name,
      this.healthPoints = 10,
      this.currentDiceRoll = 0,
      this.currentDefense = 0});

  void takeDamage(int damage) {
    healthPoints -= damage > currentDefense ? (damage - currentDefense) : 0;
  }

  void resetStats() {
    healthPoints = 10;
    currentDiceRoll = 0;
    currentDefense = 0;
  }
}
