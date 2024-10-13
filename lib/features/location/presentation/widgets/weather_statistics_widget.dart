import 'package:flutter/material.dart';

class WeatherStatisticsWidget extends StatelessWidget {
  final double humidity;
  final double windKph;
  final double cloud;

  const WeatherStatisticsWidget({
    super.key,
    required this.humidity,
    required this.windKph,
    required this.cloud,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatColumn(Icons.water_drop, humidity, 'Humidity', Colors.blue,
            size, isPortrait),
        _buildStatColumn(
            Icons.air, windKph, 'Wind Speed', Colors.orange, size, isPortrait),
        _buildStatColumn(
            Icons.cloud, cloud, 'Cloud Cover', Colors.white, size, isPortrait),
      ],
    );
  }

  Column _buildStatColumn(IconData icon, double value, String label,
      Color color, Size size, bool isPortrait) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: isPortrait
              ? size.height * 0.055
              : size.width * 0.05, 
        ),
        const SizedBox(height: 5),
        Text(
          '$value${label == 'Humidity' ? '%' : ' kph'}',
          style: TextStyle(
            color: Colors.white,
            fontSize: isPortrait
                ? size.height * 0.02
                : size.width * 0.02, 
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: isPortrait
                ? size.height * 0.020
                : size.width * 0.020, 
          ),
        ),
      ],
    );
  }
}
