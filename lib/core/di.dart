import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennis_app/features/auth/data/auth_repository_impl.dart';
import 'package:tennis_app/features/auth/data/datasources/remote/auth_data_source.dart';
import 'package:tennis_app/features/auth/data/datasources/remote/auth_repository_impl.dart';
import 'package:tennis_app/features/auth/domain/auth_repository.dart';
import 'package:tennis_app/features/auth/domain/use_case/log_in.dart';
import 'package:tennis_app/features/auth/domain/use_case/sign_up.dart';
import 'package:tennis_app/features/location/data/datasources/remote/location_weather_data_source.dart';
import 'package:tennis_app/features/location/data/datasources/remote/location_weather_data_source_impl.dart';
import 'package:tennis_app/features/location/data/location_weather_repo_impl.dart';
import 'package:tennis_app/features/location/domain/location_weather_repo.dart';
import 'package:tennis_app/features/location/domain/use_case/get_city_name_from_coordinates.dart';
import 'package:tennis_app/features/location/domain/use_case/get_current_location.dart';
import 'package:tennis_app/features/location/domain/use_case/get_forecast.dart';
import 'package:tennis_app/features/location/domain/use_case/get_weather.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  final firebaseAuth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  getIt.registerLazySingleton<LocationWeatherDataSource>(
    () => LocationWeatherDataSourceImpl(),
  );
  getIt.registerLazySingleton<LocationWeatherRepository>(
    () => LocationWeatherRepositoryImpl(
      getIt<LocationWeatherDataSource>(),
    ),
  );

  getIt.registerLazySingleton(
      () => GetCurrentLocation(getIt<LocationWeatherRepository>()));
  getIt.registerLazySingleton(
      () => GetCityNameFromCoordinates(getIt<LocationWeatherRepository>()));
  getIt.registerLazySingleton(
      () => GetWeather(getIt<LocationWeatherRepository>()));
  getIt.registerLazySingleton(
      () => GetForecast(getIt<LocationWeatherRepository>()));

  getIt.registerLazySingleton<AuthenticationDataSource>(
    () => AuthenticationDataSourceImpl(
      firebaseAuth: firebaseAuth,
      firestore: firestore,
    ),
  );
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(getIt<AuthenticationDataSource>()),
  );
  getIt.registerLazySingleton(
      () => SignUpUseCase(getIt<AuthenticationRepository>()));
  getIt.registerLazySingleton(
      () => LogInUseCase(getIt<AuthenticationRepository>()));
}
