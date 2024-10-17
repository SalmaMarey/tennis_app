import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:tennis_app/core/di.dart';
import 'package:tennis_app/features/auth/domain/use_case/log_in.dart';
import 'package:tennis_app/features/auth/domain/use_case/sign_up.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:tennis_app/features/location/domain/location_weather_repo.dart';
import 'package:tennis_app/features/location/domain/use_case/get_city_name_from_coordinates.dart';
import 'package:tennis_app/features/location/domain/use_case/get_current_location.dart';
import 'package:tennis_app/features/location/domain/use_case/get_forecast.dart';
import 'package:tennis_app/features/location/domain/use_case/get_weather.dart';
import 'package:tennis_app/features/on_boarding/presentation/controllers/on_boarding_bloc/on_boarding_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tennis_app/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'core/router/app_router.dart';
import 'features/location/presentation/controller/get_location/get_location_bloc.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();
  setupDependencies();
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnBoardingBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            signUpUseCase: getIt<SignUpUseCase>(),
            logInUseCase: getIt<LogInUseCase>(),
          ),
        ),
        BlocProvider(
  create: (context) => LocationBloc(
    getCurrentLocation: getIt<GetCurrentLocation>(),
    getCityNameFromCoordinates: getIt<GetCityNameFromCoordinates>(),
    getWeather: getIt<GetWeather>(),
    getForecast: getIt<GetForecast>(),
    repository: getIt<LocationWeatherRepository>(), 
  ),
),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter().generateRoute,
        home: const OnBoardingScreen(),
      ),
    );
  }
}
