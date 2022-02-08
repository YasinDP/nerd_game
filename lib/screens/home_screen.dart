import 'package:flutter/material.dart';
import 'package:nerd_game/constants.dart';
import 'package:nerd_game/screens/credits_screen.dart';
import 'package:nerd_game/screens/games_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kBackgroundColor,
          title: Image.asset(
            "images/appbar-icon.png",
            fit: BoxFit.contain,
          ),
          bottom: const TabBar(
            indicatorColor: kPrimaryColor,
            tabs: [
              Tab(
                text: "Game Room",
                icon: Icon(Icons.games),
              ),
              Tab(
                text: "Credits",
                icon: Icon(Icons.info),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GameScreen(),
            CredistScreen(),
          ],
        ),
      ),
    );
  }
}
