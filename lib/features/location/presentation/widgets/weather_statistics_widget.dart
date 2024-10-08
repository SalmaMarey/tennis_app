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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatColumn(Icons.water_drop, humidity, 'Humidity', Colors.blue),
        _buildStatColumn(Icons.air, windKph, 'Wind Speed', Colors.orange),
        _buildStatColumn(Icons.cloud, cloud, 'Cloud Cover', Colors.white),
      ],
    );
  }

  Column _buildStatColumn(IconData icon, double value, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
          size: 40,
        ),
        const SizedBox(height: 5),
        Text(
          '$value${label == 'Humidity' ? '%' : ' kph'}',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
           
          ),
        ),
      ],
    );
  }
}
