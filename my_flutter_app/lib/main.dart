import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_model.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Погода',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  String? _error;

  void _search() async {
    try {
      final weather = await _weatherService.getWeather(_controller.text);
      setState(() {
        _weather = weather;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _weather = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Прогноз погоди')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Введи місто'),
            ),
            ElevatedButton(
              onPressed: _search,
              child: Text('Пошук'),
            ),
            SizedBox(height: 20),
            if (_weather != null) ...[
              Text('Місто: ${_weather!.cityName}', style: TextStyle(fontSize: 20)),
              Text('Температура: ${_weather!.temperature}°C'),
              Text('Опис: ${_weather!.description}'),
            ] else if (_error != null) ...[
              Text('Помилка: $_error', style: TextStyle(color: Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}
