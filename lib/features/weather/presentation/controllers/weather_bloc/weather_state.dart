import 'package:tennis_app/core/models/daily_forecast.dart';


abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final String city;
  final double temperature;
  final double windKph;
  final int humidity;
  final int cloud;
  final List<DailyForecast> forecast;

  WeatherLoaded({
    required this.city,
    required this.temperature,
    required this.windKph,
    required this.humidity,
    required this.cloud,
    required this.forecast,
  });
}

class WeatherError extends WeatherState {
  final Exception error; 

  WeatherError(this.error);
   String get message => error.toString();
}