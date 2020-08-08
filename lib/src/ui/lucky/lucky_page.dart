import 'package:flutter/material.dart';
import 'package:music_recommendation/src/common/global_bloc.dart';
import 'package:music_recommendation/src/common/recommendation.dart';
import 'package:music_recommendation/src/ui/common/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LuckyPage extends StatelessWidget {
  const LuckyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF0075ff),
        title: Text(
          "Feeling Lucky",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: StreamBuilder<Recommendation>(
            stream: _globalBloc.luckyRecommendation,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return MusiemotionLoadingIndicator();
              }
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AlbumArt(songID: snapshot.data.getSongId),
                    SongInfo(
                      songName: snapshot.data.getSongName,
                      artistName: snapshot.data.getArtistName,
                    ),
                    ListenButton(songID: snapshot.data.getSongId),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AlbumArt extends StatelessWidget {
  final String songID;

  const AlbumArt({Key key, this.songID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF0075ff), width: 5),
      ),
      child: Center(
        child: FutureBuilder<String>(
          future: _globalBloc.getSongImageURL(songID),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Icon(
                Icons.music_note,
                color: Color(0xFF0075ff),
              );
            }
            return Image.network(
              snapshot.data,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress != null) {
                  return Icon(
                    Icons.music_note,
                    color: Color(0xFF0075ff),
                  );
                }
                return child;
              },
            );
          },
        ),
      ),
    );
  }
}

class SongInfo extends StatelessWidget {
  final String songName;
  final String artistName;

  const SongInfo({Key key, this.songName, this.artistName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          songName + "\n",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Song by " + artistName.substring(2, artistName.length - 2),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ListenButton extends StatelessWidget {
  final String songID;

  const ListenButton({Key key, this.songID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      child: RaisedButton(
        onPressed: () {
          launchURL(songID);
        },
        shape: StadiumBorder(),
        color: Color(0xFF0075ff),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Listen on  ",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
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
