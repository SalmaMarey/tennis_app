import 'package:tennis_app/features/location/domain/location_weather_repo.dart';

class GetCityNameFromCoordinates {
  final LocationWeatherRepository repository;

  GetCityNameFromCoordinates(this.repository);

  Future<String> call(double latitude, double longitude) async {
    return await repository.getCityNameFromCoordinates(latitude, longitude);
  }
}
