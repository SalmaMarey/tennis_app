import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tennis_app/core/models/weather_info_helper.dart';
import 'package:tennis_app/features/weather/presentation/controllers/weather_bloc/weather_bloc.dart';
import 'package:tennis_app/features/weather/presentation/controllers/weather_bloc/weather_event.dart';
import 'package:tennis_app/features/weather/presentation/controllers/weather_bloc/weather_state.dart';
import 'package:tennis_app/features/weather/presentation/widgets/forecast_widget.dart';
import 'package:tennis_app/features/weather/presentation/widgets/weather_statistics_widget.dart';


class WeatherScreen extends StatefulWidget {
  final String city;

  const WeatherScreen({
    super.key,
    required this.city,
  });

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeatherEvent(widget.city));
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final String currentDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    final String currentTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 33, 60),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final weatherInfo = getWeatherInfo(state.temperature);
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      _capitalizeFirstLetter(widget.city),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      weatherInfo.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 250,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 30,
                            top: 25,
                            child: Opacity(
                              opacity: 0.6,
                              child: Image.asset(
                                weatherInfo.imagePath,
                                height: 200,
                              ),
                            ),
                          ),
                          Text(
                            '${state.temperature.toInt()}°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 150,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '$currentDate at $currentTime',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    WeatherStatisticsWidget(
                      humidity: state.humidity,
                      windKph: state.windKph,
                      cloud: state.cloud,
                    ),
                    const SizedBox(height: 20),
                    ForecastWidget(
                      forecast: state.forecast,
                      city: widget.city,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is WeatherError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No weather data available.'));
        },
      ),
    );
  }
}