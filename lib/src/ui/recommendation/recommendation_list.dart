import 'package:flutter/material.dart';
import 'package:music_recommendation/src/common/global_bloc.dart';
import 'package:music_recommendation/src/common/recommendation.dart';
import 'package:provider/provider.dart';

class RecommendationPage extends StatelessWidget {
  final String emotion;
  const RecommendationPage({Key key, this.emotion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  child: Center(
                    child: Text(
                      emotion,
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF0075ff),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 8,
              child: StreamBuilder<List<Recommendation>>(
                stream: _globalBloc.recommendationList,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final List<Recommendation> _recommendationList =
                      snapshot.data;
                  return Container(
                    height: double.infinity,
                    child: ListView.builder(
                      itemCount: _recommendationList.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return RecommendationPanel(
                            recommendation: _recommendationList[index]);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecommendationPanel extends StatelessWidget {
  final Recommendation recommendation;

  const RecommendationPanel({Key key, this.recommendation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey[200],
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: 70,
                    height: 70,
                    child: Center(
                      child: Icon(
                        Icons.music_note,
                        color: Color(0xFF0075ff),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            recommendation.songName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          recommendation.artistName.substring(
                              2, recommendation.artistName.length - 2),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0, right: 15),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Color(0xFF0075ff),
                        ),
                        Text(
                          " Listen on",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Image.asset("assets/images/spotify_logo.png"),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Image.asset("assets/images/youtube_logo.png"),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
