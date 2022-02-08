import 'package:flutter/material.dart';
import 'package:nerd_game/screens/gameplay_screen.dart';
import 'package:nerd_game/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        GameplayScreen.routeName: (ctx) => const GameplayScreen(),
      },
    );
  }
}
