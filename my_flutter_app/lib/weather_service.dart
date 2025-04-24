import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  static const String _apiKey = '7c1b0e78cbf7422e097ffe7bc2a20ac4';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Weather> getWeather(String city) async {
    final url = Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric&lang=ua');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Помилка при завантаженні погоди');
    }
  }
}
