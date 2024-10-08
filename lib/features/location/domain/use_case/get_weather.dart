import 'package:tennis_app/features/location/domain/location_weather_repo.dart';

class GetWeather {
  final LocationWeatherRepository repository;

  GetWeather(this.repository);

  Future<Map<String, dynamic>> call(String city) async {
    return await repository.getWeather(city);
  }
}
