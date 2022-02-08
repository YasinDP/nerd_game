import 'package:flutter/material.dart';
import 'package:nerd_game/models/player.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    Key? key,
    required this.player,
    required this.speed,
  }) : super(key: key);

  final Player player;
  final int speed;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      // duration set based on speed also set to accept any integer value
      duration: Duration(
          milliseconds: speed > 2
              ? 100
              : speed == 2
                  ? 500
                  : 1000),
      opacity: player.isActive ? 1 : 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: player.color,
        ),
        child: Center(
          child: Text(
            player.id.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
