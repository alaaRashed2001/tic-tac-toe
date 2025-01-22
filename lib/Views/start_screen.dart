import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Helpers/snackbar.dart';
import 'package:tic_tac_toe/Widgets/custom_button.dart';
import 'game_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SnackBarHelper {
  final TextEditingController _usernameController = TextEditingController();

  void _navigateToGameScreen(bool isCreator) {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      showSnackBar(context, message: 'Please enter your username', error: true);

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            GameScreen(username: username, isCreator: isCreator),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome to Tic Tac Toe',
          style: TextStyle(
              fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () => _navigateToGameScreen(true),
                  text: "Create",
                ),
                CustomButton(
                  onPressed: () => _navigateToGameScreen(false),
                  text: "Join",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
