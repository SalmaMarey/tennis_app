import 'package:flutter/material.dart';
import 'package:tennis_app/features/location/presentation/widgets/city_search_widget.dart';
import 'package:tennis_app/features/location/presentation/widgets/current_location_button_widget.dart';

class LocationWeatherScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const LocationWeatherScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });
  @override
  State<LocationWeatherScreen> createState() => _LocationWeatherScreenState();
}

class _LocationWeatherScreenState extends State<LocationWeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  void _onGetWeather() {
    final cityName = _cityController.text.trim();
    Navigator.pushNamed(
      context,
      '/weather',
      arguments: cityName,
    );
    _cityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/world_map.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, right: 8, left: 8, bottom: 0),
          child: Column(
            children: [
              const Text(
                'Search For City',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              CitySearchWidget(
                cityController: _cityController,
                onGetWeather: _onGetWeather,
              ),
              const Spacer(),
              const CurrentLocationButton(),
            ],
          ),
        ),
      ),
    );
  }
}
