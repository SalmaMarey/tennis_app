import 'package:tennis_app/core/models/daily_forecast.dart';


abstract class WeatherRepository {
  Future<Map<String, dynamic>> getWeather(String city);
  Future<Map<String, dynamic>> getCurrentWeather(String city); 
  Future<List<DailyForecast>> getForecastWeather(String city); 
}
