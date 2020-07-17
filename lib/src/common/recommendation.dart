class Recommendation {
  final String songId;
  final String songName;
  final String artistName;

  Recommendation({this.songId, this.songName, this.artistName});

  String get getSongId => songId;
  String get getSongName => songName;
  String get getArtistName => artistName;

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      songId: json['id'],
      songName: json['name'],
      artistName: json['artists'],
    );
  }
}
