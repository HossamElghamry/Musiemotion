import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  child: Text(
                    "How are you feeling?",
                    style: TextStyle(
                      fontSize: 26,
                      color: Color(0xFF0075ff),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15),
                  child: Container(
                    height: double.infinity,
                    child: GridView.count(
                      padding: EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        EmotionBox(
                          emotion: "Happy",
                        ),
                        EmotionBox(
                          emotion: "Neutral",
                        ),
                        EmotionBox(
                          emotion: "Meh",
                        ),
                        EmotionBox(
                          emotion: "Down",
                        ),
                        EmotionBox(
                          emotion: "Frustrated",
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmotionBox extends StatelessWidget {
  final String emotion;

  const EmotionBox({Key key, this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF0075ff)),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: FlatButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        highlightColor: Colors.lightBlue[100],
        child: Center(
          child: Text(
            emotion,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF0075ff),
            ),
          ),
        ),
      ),
    );
  }
}
