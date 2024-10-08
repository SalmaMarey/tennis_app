import 'package:flutter/material.dart';

class WeatherStatisticsWidget extends StatelessWidget {
  final int humidity;
  final double windKph;
  final int cloud;

  const WeatherStatisticsWidget({
    super.key,
    required this.humidity,
    required this.windKph,
    required this.cloud,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.7),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn(Icons.water_drop, '$humidity%', 'Humidity', Colors.blue),
          _buildStatColumn(Icons.air, '$windKph kph', 'Wind Speed', Colors.orange),
          _buildStatColumn(Icons.cloud, '$cloud%', 'Cloud Cover', Colors.white),
        ],
      ),
    );
  }

  Widget _buildStatColumn(IconData icon, String value, String label, Color iconColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor, 
          size: 40,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
