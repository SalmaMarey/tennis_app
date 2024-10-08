import 'package:tennis_app/features/weather/domain/weather_repository.dart';

class CurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  CurrentWeatherUseCase(this.weatherRepository);

  Future<Map<String, dynamic>> execute(String city) {
    return weatherRepository.getCurrentWeather(city);
  }
}
