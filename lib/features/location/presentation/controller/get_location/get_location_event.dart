part of 'get_location_bloc.dart';

@immutable
abstract class LocationEvent {}

class GetLocationEvent extends LocationEvent {
  final String cityName;

  GetLocationEvent({required this.cityName});
}
class GetPredictionEvent extends LocationEvent {
  final Map<String, String> weatherData; 

  GetPredictionEvent(this.weatherData);
}