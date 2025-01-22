import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Widgets/custom_button.dart';

mixin WinnerDialogMixin {
  void showWinnerDialog({
    required BuildContext context,
    required String winner,
    required VoidCallback onRestart,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white38,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  winner == 'Draw' ? 'It\'s a Draw!' : '$winner Wins!',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.red, Colors.orange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.emoji_events,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Restart Game',
                  onPressed: () {
                    Navigator.pop(context);
                    onRestart();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
