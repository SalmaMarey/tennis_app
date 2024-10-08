import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennis_app/core/models/daily_forecast.dart';
import 'package:tennis_app/core/models/weather_info_helper.dart';

class ForecastWidget extends StatelessWidget {
  final List<DailyForecast> forecast;
  final String city;

  const ForecastWidget({
    super.key,
    required this.forecast,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final forecastDay = forecast[index];
          final weatherInfo = getWeatherInfo(forecastDay.temperature);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              height: 90,
              width: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.withOpacity(0.7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    weatherInfo.imagePath,
                    height: 40,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('EEE').format(DateTime.parse(forecastDay.date)),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${forecastDay.temperature.toInt()}°',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    weatherInfo.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 33, 60),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
