import 'package:flutter/material.dart';
import 'package:nerd_game/widgets/game_card.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 10),
        // 3 game modes with random player count and speed
        GameCard(playerCount: 100, speed: 1),
        GameCard(playerCount: 50, speed: 2),
        GameCard(playerCount: 150, speed: 3),
      ],
    );
  }
}
