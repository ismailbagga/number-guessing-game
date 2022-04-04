import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_game/providers/AuthProvider.dart';
import 'package:number_game/screens/challenges_screen.dart';
import 'package:number_game/screens/levels_screen.dart';
import 'package:number_game/screens/play_screen.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  static const path = "/menu";
  void naviagateTo(String path, BuildContext context) {
    print('Navigate');
    Navigator.of(context).pushNamed(path);
  }

  Widget buttonBuilder(String text, VoidCallback onClick,
      {double width = 300, double margin = 20, Color color = Colors.white}) {
    return Container(
      width: width,
      color: Colors.black,
      height: 80,
      margin: EdgeInsets.only(top: margin),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          onPrimary: color == Colors.white ? Colors.blue : Colors.white,
          primary: color,
          // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
        ),
        child: FittedBox(
            child: Text(text,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w700))),
      ),
    );
  }

  Widget buttonWithIcon(String text, VoidCallback onClick) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(top: 20),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: buttonBuilder(text, onClick, width: 100, margin: 0)),
        Container(
          color: const Color.fromARGB(255, 9, 156, 230),
          child: InkWell(
            onTap: onClick,
            child: const Icon(
              Icons.arrow_circle_right_outlined,
              size: 80,
              color: Color.fromARGB(255, 254, 255, 255),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = Provider.of<AuthProvider>(context).isUserLoggedIn();
    final query = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 31, 5),
      body: Center(
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            color: const Color.fromARGB(255, 5, 109, 95),
            margin: EdgeInsets.only(
              top: query.height * 0.2,
              // left: query.width * 0.05,
              // right: query.width * 0.05,
            ),
            child: const Text(
              'Two',
              style: TextStyle(fontSize: 150, fontWeight: FontWeight.w900),
            ),
            height: query.height * 0.2,
            width: query.width * 0.9,
          ),
          buttonBuilder(
            'Play',
            () => naviagateTo(PlayScreen.path, context),
            width: 320,
          ),
          buttonWithIcon(
            'Levels',
            () => naviagateTo(LevelsScreen.path, context),
          ),
          buttonBuilder(
            'More Challenges',
            () => naviagateTo(ChallengesScreen.path, context),
          ),
          if (!isLogin)
            Container(
              width: 300,
              color: Colors.blue,
              margin: const EdgeInsets.only(top: 20),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  color: const Color.fromARGB(255, 9, 156, 230),
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.facebook_sharp,
                      size: 60,
                      color: Color.fromARGB(255, 254, 255, 255),
                    ),
                  ),
                ),
                Expanded(
                    child: buttonBuilder('connect with facebook', () {},
                        width: 100, margin: 0, color: Colors.blue)),
              ]),
            )
        ]),
      ),
    );
  }
}