import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:music_recommendation/src/common/recommendation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class GlobalBloc {
  BehaviorSubject<List<Recommendation>> _recommendationList$;
  BehaviorSubject<List<Recommendation>> get recommendationList =>
      _recommendationList$;

  BehaviorSubject<Recommendation> _luckyRecommendation$;
  BehaviorSubject<Recommendation> get luckyRecommendation =>
      _luckyRecommendation$;

  GlobalBloc() {
    _recommendationList$ = BehaviorSubject<List<Recommendation>>.seeded([]);
    _luckyRecommendation$ = BehaviorSubject<Recommendation>.seeded(null);
  }

  void getRecommendations(String emotion) async {
    _recommendationList$.add([]);
    final response =
        await http.get('https://musiemotion.herokuapp.com/' + emotion + '/20');

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> result = map["result"];
      List<Recommendation> recommendationList =
          result.map((i) => Recommendation.fromJson(i)).toList();
      _recommendationList$.add(recommendationList);
    } else {
      throw Exception('Failed');
    }
  }

  void feelingLucky() async {
    _recommendationList$.add([]);
    _luckyRecommendation$.add(null);
    final response = await http.get('https://musiemotion.herokuapp.com/lucky');

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      dynamic result = map["result"];
      Recommendation luckySong = Recommendation.fromJson(result);
      _luckyRecommendation$.add(luckySong);
    } else {
      throw Exception('Failed');
    }
  }

  void refreshRecommendations(String emotion) async {
    final response =
        await http.get('https://musiemotion.herokuapp.com/' + emotion + '/20');

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> result = map["result"];
      List<Recommendation> recommendationList =
          result.map((i) => Recommendation.fromJson(i)).toList();
      _recommendationList$.add(recommendationList);
    } else {
      throw Exception('Failed');
    }
  }

  Future<String> getAuthToken() async {
    final String clientID = DotEnv().env['CLIENTID'];
    final String clientSecret = DotEnv().env['CLIENTSECRET'];
    final String credentials = clientID + ':' + clientSecret;
    String base64encoded = base64Url.encode(utf8.encode(credentials));

    var url = 'https://accounts.spotify.com/api/token';
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ' + base64encoded,
      },
      body: {'grant_type': 'client_credentials'},
    );

    Map<String, dynamic> tokenJSON = jsonDecode(response.body);
    return tokenJSON['access_token'];
  }

  Future<String> getSongImageURL(String songID) async {
    final String accessToken = await getAuthToken();
    var url = 'https://api.spotify.com/v1/tracks/' + songID;
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ' + accessToken,
      },
    );
    Map<String, dynamic> songJSON = jsonDecode(response.body);
    final String imageURL = songJSON['album']['images'][0]['url'];
    return imageURL;
  }

  void dispose() {
    _recommendationList$.close();
  }
}
