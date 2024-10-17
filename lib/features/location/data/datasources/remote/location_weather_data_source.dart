import 'package:geolocator/geolocator.dart';

abstract class LocationWeatherDataSource {
  Future<Position> getCurrentLocation();
  Future<String> getCityNameFromCoordinates(double latitude, double longitude);
  Future<Map<String, dynamic>> getWeather(String city);
  Future<Map<String, dynamic>> getForecast(String city);
  Future<int> getPrediction(List<int> features); 
}