import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/remote/weather_service.dart';
import '../../domain/models/weather_model.dart';
const String kWeatherApiKey = '52eedef491f293e0028f150a49d705a7';
const String kDefaultCity = 'Astana';

final weatherServiceProvider = Provider<WeatherService>((_) {
  return WeatherService(apiKey: kWeatherApiKey);
});

final weatherProvider =
    FutureProvider.family<WeatherModel, String>((ref, city) async {
  if (kWeatherApiKey == 'YOUR_OPENWEATHERMAP_API_KEY') {
    return WeatherModel(
      name: city,
      main: const MainWeather(temp: 22, feelsLike: 20, humidity: 45),
      weather: const [WeatherDesc(id: 801, description: 'Partly cloudy')],
      wind: const WindData(speed: 3.5),
    );
  }
  return ref.read(weatherServiceProvider).getWeatherByCity(city);
});
