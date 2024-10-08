import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tennis_app/core/models/daily_forecast.dart';
import 'package:tennis_app/features/weather/data/datasources/remote/weather_data_source.dart';



class WeatherDataSourceImpl implements WeatherDataSource {
  final String apiKey = 'e50b199406a3442d8dd232306243009';

  @override
  Future<Map<String, dynamic>> getCurrentWeather(String city) async {
    final response = await http.get(
      Uri.parse('https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['current'];
    } else {
      throw Exception('Failed to load current weather data: ${response.body}');
    }
  }

  @override
  Future<List<DailyForecast>> getForecastWeather(String city) async {
    final response = await http.get(
      Uri.parse('https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=7'),
    );

    if (response.statusCode == 200) {
      final weatherData = jsonDecode(response.body);
      final forecastData = weatherData['forecast']['forecastday'] as List;

      return forecastData.map((day) {
        return DailyForecast(
          date: day['date'],
          temperature: day['day']['avgtemp_c'].toDouble(),
          weatherCondition: day['day']['condition']['text'],
          imagePath: 'assets/weather/${day['day']['condition']['icon'].split('/').last}',
        );
      }).toList();
    } else {
      throw Exception('Failed to load forecast data: ${response.body}');
    }
  }
}