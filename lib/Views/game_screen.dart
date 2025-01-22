import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Controllers/game_logic.dart';
import 'package:tic_tac_toe/Helpers/dialog.dart';
import 'package:tic_tac_toe/Widgets/game_board.dart';
import 'package:tic_tac_toe/Widgets/score_board.dart';

class GameScreen extends StatefulWidget {
  final String username;
  final bool isCreator;

  const GameScreen(
      {super.key, required this.username, required this.isCreator});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with WinnerDialogMixin {
  final GameLogic _gameLogic = GameLogic();

  @override
  void initState() {
    super.initState();
    _gameLogic.loadScores();
    _gameLogic.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _gameLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic Tac Toe - ${widget.username}',
          style: const TextStyle(
              fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Colors.red,
          size: 32,
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GameBoard(
            board: _gameLogic.board,
            onTileTap: (index) {
              _gameLogic.makeMove(index);
              if (_gameLogic.isGameOver) {
                showWinnerDialog(
                  context: context,
                  winner: _gameLogic.winner,
                  onRestart: _gameLogic.resetGame,
                );
              }
            },
          ),
          const SizedBox(height: 20),
          ScoreBoard(scores: _gameLogic.scores),
        ],
      ),
    );
  }
}

// class GameScreen extends StatefulWidget {
//   final String username;
//   final bool isCreator;
//
//   const GameScreen({super.key, required this.username, required this.isCreator});
//
//   @override
//   State<GameScreen> createState() => _GameScreenState();
// }
//
// class _GameScreenState extends State<GameScreen> {
//   final DatabaseHelper _dbHelper = DatabaseHelper.instance;
//
//   List<String> _board = List.generate(9, (index) => '');
//   String _currentPlayer = 'X';
//   bool _isGameOver = false;
//   String _winner = '';
//   Map<String, int> _scores = {'X': 0, 'O': 0};
//
//   @override
//   void initState() {
//     super.initState();
//     _loadScores();
//   }
//
//   Future<void> _loadScores() async {
//     final scores = await _dbHelper.getScores();
//     setState(() {
//       _scores = scores;
//     });
//   }
//
//   void _resetGame() {
//     setState(() {
//       _board = List.generate(9, (index) => '');
//       _currentPlayer = 'X';
//       _isGameOver = false;
//       _winner = '';
//     });
//   }
//
//   void _makeMove(int index) {
//     if (_board[index].isNotEmpty || _isGameOver) return;
//
//     setState(() {
//       _board[index] = _currentPlayer;
//       if (_checkWinner()) {
//         _isGameOver = true;
//         _winner = _currentPlayer;
//         _dbHelper.updateScore(_currentPlayer);
//         _loadScores();
//         _showWinnerDialog();
//       } else if (!_board.contains('')) {
//         _isGameOver = true;
//         _winner = 'Draw';
//         _showWinnerDialog();
//       } else {
//         _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
//       }
//     });
//   }
//
//   bool _checkWinner() {
//     const winningCombinations = [
//       [0, 1, 2],
//       [3, 4, 5],
//       [6, 7, 8],
//       [0, 3, 6],
//       [1, 4, 7],
//       [2, 5, 8],
//       [0, 4, 8],
//       [2, 4, 6],
//     ];
//
//     for (var combo in winningCombinations) {
//       if (_board[combo[0]] == _currentPlayer &&
//           _board[combo[1]] == _currentPlayer &&
//           _board[combo[2]] == _currentPlayer) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   void _showWinnerDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           backgroundColor: Colors.black,
//           child: Container(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   _winner == 'Draw' ? 'It\'s a Draw!' : '$_winner Wins!',
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   height: 150,
//                   width: 150,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: LinearGradient(
//                       colors: [Colors.red, Colors.orange],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                   ),
//                   child: const Center(
//                     child: Icon(
//                       Icons.emoji_events,
//                       size: 80,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     _resetGame();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 30, vertical: 10),
//                   ),
//                   child: const Text(
//                     'Restart Game',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tic Tac Toe - ${widget.username}',
//           style: const TextStyle(
//             fontSize: 24,
//             color: Colors.red,
//             fontWeight: FontWeight.bold
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.red,
//           size: 32,
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GridView.builder(
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               childAspectRatio: 1,
//               crossAxisSpacing: 5,
//               mainAxisSpacing: 5,
//             ),
//             itemCount: 9,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () => _makeMove(index),
//                 child: Container(
//                   color: Colors.grey[300],
//                   child: Center(
//                     child: Text(
//                       _board[index],
//                       style: const TextStyle(
//                           fontSize: 36, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'Scores:\n\nPlayer X: ${_scores['X']},      Player O: ${_scores['O']}',
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
