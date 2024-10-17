import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:tennis_app/features/location/data/datasources/remote/location_weather_data_source.dart';

class LocationWeatherDataSourceImpl implements LocationWeatherDataSource {
  final String apiKey = 'e50b199406a3442d8dd232306243009';

  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }

  @override
  Future<String> getCityNameFromCoordinates(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      return placemarks[0].locality ?? 'Unknown city';
    }
    return 'Unknown city';
  }

  @override
  Future<Map<String, dynamic>> getWeather(String city) async {
    final String url =
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<Map<String, dynamic>> getForecast(String city) async {
    final String url =
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$city&days=7';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load forecast data');
    }
  } @override
  Future<int> getPrediction(List<int> features) async {
    final url = Uri.parse('http://192.168.1.221:5001/predict');
    Map<String, dynamic> body = {'features': features};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final prediction = json.decode(response.body)['prediction'][0];
      return prediction;
    } else {
      throw Exception('Failed to get prediction');
    }
  }
}

