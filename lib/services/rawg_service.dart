import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/game.dart';

class RawgService {
  static const String _baseUrl = 'https://api.rawg.io/api';

  static const String _apiKey =
      String.fromEnvironment('RAWG_API_KEY');

  Future<List<Game>> getGames() async {
    final url = Uri.parse(
      '$_baseUrl/games?key=$_apiKey&page_size=10',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List results = data['results'];

      return results
          .map((game) => Game.fromJson(game))
          .toList();
    }

    throw Exception(
      'Error al consultar RAWG: ${response.statusCode}',
    );
  }
}