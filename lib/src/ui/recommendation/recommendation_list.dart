import 'package:flutter/material.dart';
import 'package:music_recommendation/src/common/global_bloc.dart';
import 'package:music_recommendation/src/common/recommendation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendationPage extends StatefulWidget {
  final String emotion;
  const RecommendationPage({Key key, this.emotion}) : super(key: key);

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    ScrollController _scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.emotion,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 8.0,
        backgroundColor: Color(0xFF0075ff),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        height: double.infinity,
        child: StreamBuilder<List<Recommendation>>(
          stream: _globalBloc.recommendationList,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data.length == 0) {
              return Container(
                child: Align(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              );
            }
            final List<Recommendation> _recommendationList = snapshot.data;
            return Container(
              height: double.infinity,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _recommendationList.length + 1,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (!snapshot.hasData || snapshot.data.length == 0) {
                    return Container(
                      child: Align(
                        alignment: FractionalOffset.center,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    );
                  } else if (index == _recommendationList.length) {
                    return Container(
                      height: 100,
                      width: 20,
                      color: Colors.transparent,
                      child: FlatButton(
                        color: Colors.grey[300],
                        onPressed: () {
                          _globalBloc.refreshRecommendations(widget.emotion);
                          _scrollController.animateTo(
                            _scrollController.position.minScrollExtent,
                            curve: Curves.easeInOutSine,
                            duration: Duration(milliseconds: 1500),
                          );
                        },
                        child: Center(
                          child: Text(
                            "Get More Recommendations",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return RecommendationPanel(
                    recommendation: _recommendationList[index],
                    index: index,
                  );
                },
              ),
            );
          },
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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        height: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 7,
          color: widget.index % 2 == 0 ? Colors.white : Color(0xFF0075ff),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
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
                            color: widget.index % 2 == 0
                                ? Colors.black
                                : Colors.white,
                            width: 1.5,
                          ),
                        ),
                        width: 60,
                        height: 60,
                        child: Center(
                          child: FutureBuilder<String>(
                            future: _globalBloc.getSongImageURL(
                                widget.recommendation.getSongId),
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
                                loadingBuilder: (BuildContext context,
                                    Widget child,
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
                              widget.recommendation.artistName.substring(2,
                                  widget.recommendation.artistName.length - 2),
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
                        flex: 2,
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
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            launchURL(widget.recommendation.getSongId);
                          },
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Image.asset(
                                      "assets/images/spotify_logo.png"),
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
        ),
      ),
    );
  }

  void launchURL(String songID) async {
    final url = 'https://open.spotify.com/track/' + songID;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
