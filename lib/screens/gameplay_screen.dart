import 'package:flutter/material.dart';
import 'package:nerd_game/constants.dart';
import 'package:nerd_game/models/player.dart';
import 'package:nerd_game/screens/winning_screen.dart';
import 'package:nerd_game/widgets/player_card.dart';

class GameplayScreen extends StatefulWidget {
  static const routeName = '/gameplay';
  const GameplayScreen({Key? key}) : super(key: key);

  @override
  State<GameplayScreen> createState() => _GameplayScreenState();
}

class _GameplayScreenState extends State<GameplayScreen> {
  late int playerCount;
  late int speed;
  List<Player> playersList = [];
  List<Player> _customList = [];
  late bool _init;
  @override
  void initState() {
    _init = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //run this function only once the widget loads
    if (_init) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      playerCount = args["player_count"] as int;
      speed = args["speed"] as int;
      playersList = List.generate(playerCount, (int i) {
        return Player(id: i + 1, color: kSecondaryColor, isActive: true);
      });
      _customList = List.generate(playerCount, (int i) {
        return Player(id: i + 1, color: kSecondaryColor, isActive: true);
      });
      _init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        foregroundColor: kPrimaryColor,
        centerTitle: true,
        title: Image.asset(
          "images/appbar-icon.png",
          fit: BoxFit.contain,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Tap on a player to start eliminating players!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                itemCount: playerCount,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => startGame(index),
                    child: Hero(
                      tag: playersList[index]
                          .id
                          .toString(), // set id as the hero tag
                      child: Material(
                        //set to fix the text style of the card text during hero animation
                        type: MaterialType.transparency,
                        child: PlayerCard(
                          player: playersList[index],
                          speed: speed,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }

  void startGame(int index) async {
    int increment = 0;
    int _index = index; // starting index
    int listLength = _customList.length;

    // duration set based on speed also set to accept any integer value
    final Duration _duration = Duration(
        milliseconds: speed > 2
            ? 100
            : speed == 2
                ? 500
                : 1000);

    // breaks out once the list only has 1 player
    while (listLength > 1) {
      _index = (increment + _index) % listLength;

      // prints and removes the required player
      Player currentPlayer = _customList.elementAt(_index);
      // print(currentPlayer.id);
      _customList.remove(currentPlayer);

      await Future.delayed(_duration, () {
        if (mounted) {
          setState(() {
            playersList[currentPlayer.id - 1] = Player(
              id: currentPlayer.id,
              color: currentPlayer.color,
              isActive: false,
            );
          });
        }
      });
      increment++;
      listLength--;
    }
    Future.delayed(_duration * 5, () {
      declareWinner(_customList[0]);
    });
  }

  //navigate to winning page
  void declareWinner(Player winner) {
    if (mounted) {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
          opaque: false,
          barrierDismissible: true,
          pageBuilder: (BuildContext context, _, __) {
            return WinningScreen(winner: winner, speed: speed);
          }));
    }
  }
}
