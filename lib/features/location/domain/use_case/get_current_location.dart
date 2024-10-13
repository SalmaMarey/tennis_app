import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/features/location/domain/location_weather_repo.dart';

class GetCurrentLocation {
  final LocationWeatherRepository repository;

  GetCurrentLocation(this.repository);

  Future<Position> call() async {
    return await repository.getCurrentLocation();
  }
}
