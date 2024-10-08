import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/features/location/data/datasources/remote/location_weather_data_source.dart';
import 'package:tennis_app/features/location/domain/location_weather_repo.dart';

class LocationWeatherRepositoryImpl implements LocationWeatherRepository {
  final LocationWeatherDataSource _dataSource;

  LocationWeatherRepositoryImpl(this._dataSource);

  @override
  Future<Position> getCurrentLocation() {
    return _dataSource.getCurrentLocation();
  }

  @override
  Future<String> getCityNameFromCoordinates(double latitude, double longitude) {
    return _dataSource.getCityNameFromCoordinates(latitude, longitude);
  }

  @override
  Future<Map<String, dynamic>> getWeather(String city) {
    return _dataSource.getWeather(city);
  }

  @override
  Future<Map<String, dynamic>> getForecast(String city) {
    return _dataSource.getForecast(city);
  }
}