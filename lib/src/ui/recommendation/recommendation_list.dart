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
                            recommendation: _recommendationList[index],
                            index: index);
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

class RecommendationPanel extends StatefulWidget {
  final Recommendation recommendation;
  final int index;

  const RecommendationPanel({Key key, this.recommendation, this.index})
      : super(key: key);

  @override
  _RecommendationPanelState createState() => _RecommendationPanelState();
}

class _RecommendationPanelState extends State<RecommendationPanel>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: widget.index % 2 == 0 ? Colors.white : Color(0xFF0075ff),
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
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            widget.index % 2 == 0 ? Colors.black : Colors.white,
                        width: 1.5,
                      ),
                    ),
                    width: 70,
                    height: 70,
                    child: Center(
                      child: FutureBuilder<String>(
                        future: _globalBloc
                            .getSongImageURL(widget.recommendation.getSongId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Icon(
                              Icons.music_note,
                              color: widget.index % 2 == 0
                                  ? Color(0xFF0075ff)
                                  : Colors.white,
                            );
                          }
                          return Image.network(
                            snapshot.data,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress != null) {
                                return Icon(
                                  Icons.music_note,
                                  color: widget.index % 2 == 0
                                      ? Color(0xFF0075ff)
                                      : Colors.white,
                                );
                              }
                              return child;
                            },
                          );
                        },
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
                            widget.recommendation.songName,
                            style: TextStyle(
                              fontSize: 16,
                              color: widget.index % 2 == 0
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          widget.recommendation.artistName.substring(
                              2, widget.recommendation.artistName.length - 2),
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.index % 2 == 0
                                ? Colors.grey[400]
                                : Colors.grey[300],
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: widget.index % 2 == 0
                              ? Color(0xFF0075ff)
                              : Colors.white,
                        ),
                        Text(
                          " Listen on",
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.index % 2 == 0
                                ? Color(0xFF0075ff)
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        print(5);
                      },
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon:
                                  Image.asset("assets/images/spotify_logo.png"),
                              onPressed: () {},
                            ),
                            Text(
                              "Spotify",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF1DB954),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
