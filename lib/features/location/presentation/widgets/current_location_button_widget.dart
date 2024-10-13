import 'package:flutter/material.dart';
import 'package:tennis_app/features/location/presentation/screens/details_screen.dart';

class CurrentLocationButton extends StatelessWidget {
  final String cityName;

  const CurrentLocationButton({super.key, required this.cityName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(cityName: cityName),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.withOpacity(0.7),
          padding: EdgeInsets.symmetric(
            horizontal: isPortrait ? size.width * 0.2 : size.width * 0.15,
            vertical: isPortrait ? size.height * 0.02 : size.height * 0.01,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(90),
              topRight: Radius.circular(90),
            ),
          ),
        ),
        child: Text(
          'Get Weather For Current Location',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 33, 60),
            fontWeight: FontWeight.bold,
            fontSize: isPortrait ? size.height * 0.03 : size.width * 0.025,
          ),
        ),
      ),
    );
  }
}
