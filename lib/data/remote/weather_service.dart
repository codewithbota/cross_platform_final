import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/weather_model.dart';

class WeatherService {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  final String apiKey;

  WeatherService({required this.apiKey});

  Future<WeatherModel> getWeatherByCity(String city) async {
    final uri = Uri.parse('$_baseUrl?q=$city&appid=$apiKey&units=metric&lang=ru');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return WeatherModel.fromJson(json);
    } else {
      throw Exception(
          'Weather API error: ${response.statusCode} — ${response.body}');
    }
  }
}