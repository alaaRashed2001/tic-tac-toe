import 'package:flutter/material.dart';
import 'DB/database_helper.dart';

class GameLogic extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  List<String> board = List.generate(9, (index) => '');
  String currentPlayer = 'X';
  bool isGameOver = false;
  String winner = '';
  Map<String, int> scores = {'X': 0, 'O': 0};

  Future<void> loadScores() async {
    final savedScores = await _dbHelper.getScores();
    scores = savedScores;
    notifyListeners();
  }

  void resetGame() {
    board = List.generate(9, (index) => '');
    currentPlayer = 'X';
    isGameOver = false;
    winner = '';
    notifyListeners();
  }

  void makeMove(int index) {
    if (board[index].isNotEmpty || isGameOver) return;

    board[index] = currentPlayer;
    if (_checkWinner()) {
      isGameOver = true;
      winner = currentPlayer;
      _dbHelper.updateScore(currentPlayer);
      loadScores();
    } else if (!board.contains('')) {
      isGameOver = true;
      winner = 'Draw';
    } else {
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }
    notifyListeners();
  }

  bool _checkWinner() {
    const winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombinations) {
      if (board[combo[0]] == currentPlayer &&
          board[combo[1]] == currentPlayer &&
          board[combo[2]] == currentPlayer) {
        return true;
      }
    }
    return false;
  }
}
