import 'package:flutter/material.dart';
import 'package:music_recommendation/src/common/global_bloc.dart';
import 'package:music_recommendation/src/common/recommendation.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LuckyPage extends StatelessWidget {
  const LuckyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      backgroundColor: Color(0xFF0075ff),
      appBar: AppBar(
        backgroundColor: Color(0xFF0075ff),
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: StreamBuilder<Recommendation>(
            stream: _globalBloc.luckyRecommendation,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return CircularProgressIndicator();
              }
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: FutureBuilder<String>(
                          future: _globalBloc
                              .getSongImageURL(snapshot.data.getSongId),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Icon(
                                Icons.music_note,
                                color: Colors.white,
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
                                    color: Colors.white,
                                  );
                                }
                                return child;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data.getSongName + "\n",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Song by " +
                              snapshot.data.getArtistName.substring(
                                  2, snapshot.data.getArtistName.length - 2),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[200],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      child: RaisedButton(
                        onPressed: () {
                          launchURL(snapshot.data.getSongId);
                        },
                        shape: StadiumBorder(),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Listen on  ",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF0075ff),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              child: Center(
                                child: Image.asset(
                                  "assets/images/spotify_logo.png",
                                ),
                              ),
                            ),
                            Text(
                              " Spotify",
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xFF1DB954),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
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
