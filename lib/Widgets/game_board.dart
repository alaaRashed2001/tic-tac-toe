import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  final List<String> board;
  final Function(int) onTileTap;

  const GameBoard({super.key, required this.board, required this.onTileTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onTileTap(index),
          child: Container(
            color: Colors.grey[300],
            child: Center(
              child: Text(
                board[index],
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
