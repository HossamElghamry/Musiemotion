import 'dart:convert';
import 'package:music_recommendation/src/common/recommendation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class GlobalBloc {
  BehaviorSubject<List<Recommendation>> _recommendationList$;
  BehaviorSubject<List<Recommendation>> get recommendationList =>
      _recommendationList$;

  GlobalBloc() {
    _recommendationList$ = BehaviorSubject<List<Recommendation>>.seeded([]);
  }

  void getRecommendations(String emotion) async {
    final response =
        await http.get('http://192.168.1.3:5000/' + emotion + '/20');

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

  void dispose() {
    _recommendationList$.close();
  }
}
