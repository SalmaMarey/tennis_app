import 'package:tennis_app/core/models/daily_forecast.dart';
import 'package:tennis_app/features/weather/data/datasources/remote/weather_data_source.dart';
import 'package:tennis_app/features/weather/domain/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherDataSource dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getCurrentWeather(String city) async {
    return await dataSource.getCurrentWeather(city);
  }

  @override
  Future<List<DailyForecast>> getForecastWeather(String city) async {
    return await dataSource.getForecastWeather(city);
  }

  @override
  Future<Map<String, dynamic>> getWeather(String city) async {
    try {
      final currentWeather = await getCurrentWeather(city);
      final forecastWeather = await getForecastWeather(city);

      return {
        'current': currentWeather,
        'forecast': forecastWeather,
      };
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}