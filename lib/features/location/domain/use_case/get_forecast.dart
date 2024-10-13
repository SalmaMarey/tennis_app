import 'package:tennis_app/features/location/domain/location_weather_repo.dart';

class GetForecast {
  final LocationWeatherRepository repository;

  GetForecast(this.repository);

  Future<Map<String, dynamic>> call(String city) async {
    return await repository.getForecast(city);
  }
}
