import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class MusiemotionLoadingIndicator extends StatelessWidget {
  const MusiemotionLoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0075ff),
      body: Container(
        child: Center(
          child: FlareActor(
            "assets/animations/loading.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "searching",
          ),
        ),
      ),
    );
  }
}
