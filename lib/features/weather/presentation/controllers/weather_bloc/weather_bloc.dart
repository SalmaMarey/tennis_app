import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/features/weather/data/models/daily_forecast_model.dart';
import 'package:tennis_app/features/weather/domain/weather_repository.dart';
import 'package:tennis_app/features/weather/presentation/controllers/weather_bloc/weather_event.dart';
import 'package:tennis_app/features/weather/presentation/controllers/weather_bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoading());

      try {
        final weatherData = await weatherRepository.getWeather(event.city);

        if (weatherData['current'] != null && weatherData['forecast'] != null) {
          final current = weatherData['current'];
          final double temperature = current['temp_c'];
          final double windKph = current['wind_kph'];
          final int humidity = current['humidity'];
          final int cloud = current['cloud'];

          final List<DailyForecast> forecast =
              (weatherData['forecast'] as List<DailyForecast>)
                  .map((day) => DailyForecast(
                        date: day.date,
                        temperature: day.temperature,
                        weatherCondition: day.weatherCondition,
                        imagePath: day.imagePath,
                      ))
                  .toList();

          emit(WeatherLoaded(
            city: event.city,
            temperature: temperature,
            windKph: windKph,
            humidity: humidity,
            cloud: cloud,
            forecast: forecast,
          ));
        } else {
          (error) {
            emit(WeatherError(error as Exception));
          };
        }
      } catch (error) {
        emit(WeatherError(error as Exception));
      }
    });
  }
}
