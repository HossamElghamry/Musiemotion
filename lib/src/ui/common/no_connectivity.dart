import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ConnectivityErrorIndicator extends StatelessWidget {
  const ConnectivityErrorIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0075ff),
      body: Container(
        child: Center(
          child: FlareActor(
            "assets/animations/no_connection.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "no_netwrok",
          ),
        ),
      ),
    );
  }
}
