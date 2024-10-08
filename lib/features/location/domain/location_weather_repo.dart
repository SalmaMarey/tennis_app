import 'package:geolocator/geolocator.dart';

abstract class LocationWeatherRepository {
  // Location methods
  Future<Position> getCurrentLocation();
  Future<String> getCityNameFromCoordinates(double latitude, double longitude);

  // Weather methods
  Future<Map<String, dynamic>> getWeather(String city);
  Future<Map<String, dynamic>> getForecast(String city);
}
