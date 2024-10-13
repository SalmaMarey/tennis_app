import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennis_app/core/models/daily_forecast.dart';
import 'package:tennis_app/core/models/weather_info_helper.dart';

class ForecastWidget extends StatelessWidget {
  final List<DailyForecast> forecast;

  const ForecastWidget({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return SizedBox(
      width: size.width * 0.95,
      height: isPortrait
          ? size.height * 0.24
          : size.height * 0.3, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final forecastDay = forecast[index];
          final weatherInfo = getWeatherInfo(forecastDay.temperature);

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isPortrait
                  ? size.width * 0.085
                  : size.width * 0.03,
            ),
            child: Container(
              height: isPortrait
                  ? size.height * 0.48
                  : size.height * 0.55, 
              width: isPortrait
                  ? size.width * 0.15
                  : size.width * 0.12, 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.grey.withOpacity(0.7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    weatherInfo.imagePath,
                    height: isPortrait
                        ? size.height * 0.06
                        : size.height * 0.08, 
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat('EEE').format(DateTime.parse(forecastDay.date)),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isPortrait
                          ? size.height * 0.02
                          : size.width * 0.02, 
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${forecastDay.temperature.toInt()}°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isPortrait
                          ? size.height * 0.02
                          : size.width * 0.02,
                    ),
                  ),
                  Text(
                    weatherInfo.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 33, 60),
                      fontSize: isPortrait
                          ? size.height * 0.018
                          : size.width * 0.025, 
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
