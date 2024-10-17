part of 'get_location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Position position;
  final dynamic weatherData; 
  final List<DailyForecast> forecast;

  LocationLoaded({
    required this.position,
    required this.weatherData,
    required this.forecast,
  });
}

class LocationError extends LocationState {
  final Exception error;

  LocationError(this.error);
}

class PredictionResult extends LocationState {
  final dynamic prediction;

  PredictionResult(this.prediction);
}
