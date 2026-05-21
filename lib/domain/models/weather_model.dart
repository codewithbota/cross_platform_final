import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final String name; // city name
  final MainWeather main;
  final List<WeatherDesc> weather;
  final WindData wind;

  const WeatherModel({
    required this.name,
    required this.main,
    required this.weather,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  String get description => weather.isNotEmpty ? weather.first.description : '';
  String get emoji {
    if (weather.isEmpty) return '🌤';
    final id = weather.first.id;
    if (id < 300) return '⛈';
    if (id < 500) return '🌦';
    if (id < 600) return '🌧';
    if (id < 700) return '❄️';
    if (id < 800) return '🌫';
    if (id == 800) return '☀️';
    if (id < 803) return '⛅';
    return '☁️';
  }
}

@JsonSerializable()
class MainWeather {
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  final int humidity;

  const MainWeather(
      {required this.temp,
      required this.feelsLike,
      required this.humidity});

  factory MainWeather.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$MainWeatherToJson(this);
}

@JsonSerializable()
class WeatherDesc {
  final int id;
  final String description;

  const WeatherDesc({required this.id, required this.description});

  factory WeatherDesc.fromJson(Map<String, dynamic> json) =>
      _$WeatherDescFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDescToJson(this);
}

@JsonSerializable()
class WindData {
  final double speed;

  const WindData({required this.speed});

  factory WindData.fromJson(Map<String, dynamic> json) =>
      _$WindDataFromJson(json);
  Map<String, dynamic> toJson() => _$WindDataToJson(this);
}
