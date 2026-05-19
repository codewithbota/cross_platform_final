// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      name: json['name'] as String,
      main: MainWeather.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherDesc.fromJson(e as Map<String, dynamic>))
          .toList(),
      wind: WindData.fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'main': instance.main,
      'weather': instance.weather,
      'wind': instance.wind,
    };

MainWeather _$MainWeatherFromJson(Map<String, dynamic> json) => MainWeather(
      temp: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
    );

Map<String, dynamic> _$MainWeatherToJson(MainWeather instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'humidity': instance.humidity,
    };

WeatherDesc _$WeatherDescFromJson(Map<String, dynamic> json) => WeatherDesc(
      id: (json['id'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$WeatherDescToJson(WeatherDesc instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
    };

WindData _$WindDataFromJson(Map<String, dynamic> json) => WindData(
      speed: (json['speed'] as num).toDouble(),
    );

Map<String, dynamic> _$WindDataToJson(WindData instance) => <String, dynamic>{
      'speed': instance.speed,
    };
