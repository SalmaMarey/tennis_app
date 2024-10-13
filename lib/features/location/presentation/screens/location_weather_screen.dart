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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/world_map.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: isPortrait ? size.height * 0.05 : size.height * 0.03,
            right: size.width * 0.02,
            left: size.width * 0.02,
            // bottom: size.height * 0.02,
          ),
          child: Column(
            children: [
              Text(
                'Search For City',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isPortrait ? size.height * 0.04 : size.width * 0.04,
                ),
              ),
              SizedBox(
                  height: isPortrait ? size.height * 0.02 : size.height * 0.01),
              CitySearchWidget(
                cityController: _cityController,
              ),
              const Spacer(),
              const CurrentLocationButton(cityName: ''),
              // SizedBox(
              //     height: isPortrait ? size.height * 0.05 : size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
