import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:tennis_app/core/models/daily_forecast.dart';
import 'package:tennis_app/features/location/domain/use_case/get_current_location.dart';
import 'package:tennis_app/features/location/domain/use_case/get_city_name_from_coordinates.dart';
import 'package:tennis_app/features/location/domain/use_case/get_weather.dart';
import 'package:tennis_app/features/location/domain/use_case/get_forecast.dart';


part 'get_location_event.dart';
part 'get_location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocation getCurrentLocation;
  final GetCityNameFromCoordinates getCityNameFromCoordinates;
  final GetWeather getWeather;
  final GetForecast getForecast;

  LocationBloc({
    required this.getCurrentLocation,
    required this.getCityNameFromCoordinates,
    required this.getWeather,
    required this.getForecast,
  }) : super(LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationLoading());
      try {
        final position = await getCurrentLocation();
        final city = await getCityNameFromCoordinates(
            position.latitude, position.longitude);

        final weatherData = await getWeather(city);
        final forecastData = await getForecast(city);

        List<DailyForecast> forecastList =
            (forecastData['forecast']['forecastday'] as List)
                .map((day) => DailyForecast(
                      date: day['date'],
                      temperature: day['day']['avgtemp_c'],
                      weatherCondition: day['day']['condition']['text'],
                      imagePath: day['day']['condition']['icon'],
                    ))
                .toList();

        emit(LocationLoaded(
            position: position,
            weatherData: weatherData,
            forecast: forecastList));
      } catch (e) {
        emit(LocationError(e as Exception));
      }
    });
  }
}
