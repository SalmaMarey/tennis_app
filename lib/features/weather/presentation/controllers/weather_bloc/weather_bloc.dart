import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/core/models/daily_forecast.dart';
import 'package:tennis_app/features/weather/domain/use_case/current_weather.dart';
import 'package:tennis_app/features/weather/domain/use_case/forecast_weather.dart';
import 'package:tennis_app/features/weather/presentation/controllers/weather_bloc/weather_event.dart';
import 'package:tennis_app/features/weather/presentation/controllers/weather_bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final CurrentWeatherUseCase currentWeatherUseCase;
  final ForecastWeatherUseCase forecastWeatherUseCase;

  WeatherBloc(this.currentWeatherUseCase, this.forecastWeatherUseCase) : super(WeatherInitial()) {
    on<FetchWeatherEvent>((event, emit) async {
      emit(WeatherLoading());

      try {
        final currentWeather = await currentWeatherUseCase.execute(event.city);
        final forecastWeather = await forecastWeatherUseCase.execute(event.city);

        final double temperature = currentWeather['temp_c'];
        final double windKph = currentWeather['wind_kph'];
        final int humidity = currentWeather['humidity'];
        final int cloud = currentWeather['cloud'];

        final List<DailyForecast> forecast = forecastWeather;

        emit(WeatherLoaded(
          city: event.city,
          temperature: temperature,
          windKph: windKph,
          humidity: humidity,
          cloud: cloud,
          forecast: forecast,
        ));
      } catch (error) {
        emit(WeatherError(error as Exception));
      }
    });
  }
}
