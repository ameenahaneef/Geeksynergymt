import 'dart:convert';
import 'package:geeksynergymt/core/endpoints/end_points.dart';
import 'package:geeksynergymt/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String postUrl = EndPoints.postUrl;

  Future<List<Movie>> fetchMovies({
    required String category,
    required String language,
    required String genre,
    required String sort,
  }) async {
    final response = await http.post(
      Uri.parse(postUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'category': category,
        'language': language,
        'genre': genre,
        'sort': sort,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['code'] == 1) {
        final List<dynamic> result = data['result'];
        return result.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
