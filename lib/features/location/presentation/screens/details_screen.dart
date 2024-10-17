import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/core/models/weather_info_helper.dart';
import 'package:tennis_app/features/location/presentation/controller/get_location/get_location_bloc.dart';
import 'package:tennis_app/features/location/presentation/widgets/forecast_widget.dart';
import 'package:tennis_app/features/location/presentation/widgets/prediction_widget.dart';
import 'package:tennis_app/features/location/presentation/widgets/weather_statistics_widget.dart';
import 'package:tennis_app/features/location/domain/location_weather_repo.dart';

class DetailsScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final String? cityName;
  final Map<String, dynamic>? weatherData;

  const DetailsScreen({
    super.key,
    this.latitude,
    this.longitude,
    this.cityName,
    this.weatherData,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late LocationWeatherRepository repository;

  @override
  void initState() {
    super.initState();
    repository = BlocProvider.of<LocationBloc>(context).repository;

    BlocProvider.of<LocationBloc>(context).add(
      GetLocationEvent(cityName: widget.cityName ?? ''),
    );
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void _showPredictionDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LocationError) {
          return Center(
            child: Text('Error: ${state.error.toString()}'),
          );
        } else if (state is LocationLoaded) {
          final currentWeatherData = widget.weatherData ?? state.weatherData;
          final forecast = state.forecast;
          final cityName = currentWeatherData['location']['name'];
          final tempC = currentWeatherData['current']['temp_c'];
          final humidity =
              (currentWeatherData['current']['humidity'] as num).toDouble();
          final windKph =
              (currentWeatherData['current']['wind_kph'] as num).toDouble();
          final cloud =
              (currentWeatherData['current']['cloud'] as num).toDouble();
          final weatherInfo = getWeatherInfo(tempC);
          final String currentDate =
              DateFormat('dd MMM yyyy').format(DateTime.now());
          final String currentTime =
              DateFormat('hh:mm a').format(DateTime.now());

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 0, 33, 60),
            body: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                        isPortrait ? size.width * 0.05 : size.width * 0.03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: isPortrait
                                ? size.height * 0.02
                                : size.height * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _capitalizeFirstLetter(cityName),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isPortrait
                                    ? size.height * 0.04
                                    : size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PredictionWidget(
                              tempC: tempC,
                              humidity: humidity,
                              cloud: cloud,
                              showPredictionDialog: _showPredictionDialog,
                            ),
                          ],
                        ),
                        SizedBox(
                            height: isPortrait
                                ? size.height * 0.01
                                : size.height * 0.005),
                        Text(
                          weatherInfo.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isPortrait
                                ? size.height * 0.025
                                : size.width * 0.025,
                          ),
                        ),
                        SizedBox(
                            height: isPortrait
                                ? size.height * 0.01
                                : size.height * 0.005),
                        SizedBox(
                          height: isPortrait
                              ? size.height * 0.28
                              : size.height * 0.18,
                          child: Stack(
                            children: [
                              Positioned(
                                left: size.width * 0.02,
                                top: size.height * 0.035,
                                child: Opacity(
                                  opacity: 0.6,
                                  child: Image.asset(
                                    weatherInfo.imagePath,
                                    height: isPortrait
                                        ? size.height * 0.25
                                        : size.height * 0.2,
                                  ),
                                ),
                              ),
                              Text(
                                '${tempC.toInt()}°',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isPortrait
                                      ? size.height * 0.18
                                      : size.width * 0.15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '$currentDate at $currentTime',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isPortrait
                                ? size.height * 0.025
                                : size.width * 0.025,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(
                            height: isPortrait
                                ? size.height * 0.02
                                : size.height * 0.015),
                        Container(
                          width: size.width * 0.9,
                          height: isPortrait
                              ? size.height * 0.18
                              : size.height * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: WeatherStatisticsWidget(
                            humidity: humidity,
                            windKph: windKph,
                            cloud: cloud,
                          ),
                        ),
                        SizedBox(
                            height: isPortrait
                                ? size.height * 0.05
                                : size.height * 0.03),
                        ForecastWidget(forecast: forecast),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: Text('Failed to load data'));
      },
    );
  }
}
