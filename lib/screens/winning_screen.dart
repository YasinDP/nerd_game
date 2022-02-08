import 'package:flutter/material.dart';
import 'package:nerd_game/constants.dart';
import 'package:nerd_game/models/player.dart';
import 'package:nerd_game/widgets/player_card.dart';

class WinningScreen extends StatefulWidget {
  const WinningScreen({
    Key? key,
    required this.winner,
    required this.speed,
  }) : super(key: key);

  final Player winner;
  final int speed;

  @override
  State<WinningScreen> createState() => _WinningScreenState();
}

class _WinningScreenState extends State<WinningScreen>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: height * 0.2),
            const Text(
              "Winner",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 50),
            FadeTransition(
              opacity: _fadeInFadeOut,
              child: SizedBox(
                width: 150,
                height: 150,
                child: Hero(
                  tag: widget.winner.id.toString(),
                  child: Material(
                      //set to fix the text style of the card text during hero animation
                      type: MaterialType.transparency,
                      child: PlayerCard(
                          player: widget.winner, speed: widget.speed)),
                ),
              ),
            ),
            SizedBox(height: height * 0.2),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: width * 0.2, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kPrimaryColor.withOpacity(0.9),
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.2),
          ],
        ),
      ),
    );
  }
}
