part of 'get_location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationError extends LocationState {
    final Exception error; 
  
  LocationError(this.error);
}

class LocationLoaded extends LocationState {
  final Position position;
  final Map<String, dynamic> weatherData;
  final List<DailyForecast> forecast;

  LocationLoaded({
    required this.position,
    required this.weatherData,
    required this.forecast,
  });
}