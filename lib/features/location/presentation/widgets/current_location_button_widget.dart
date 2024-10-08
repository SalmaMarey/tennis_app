import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/features/location/presentation/controller/get_location/get_location_bloc.dart';
import 'package:tennis_app/core/error/error_handler.dart';

class CurrentLocationButton extends StatelessWidget {
  const CurrentLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          Navigator.of(context).pushNamed('/details', arguments: {
            'latitude': state.position.latitude,
            'longitude': state.position.longitude,
            'weatherData': state.weatherData,
          });
        } else if (state is LocationError) {
          final failure = ErrorHandler.handleError(state.error);
          ErrorHandler.showErrorDialog(context, failure.message);
        }
      },
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            BlocProvider.of<LocationBloc>(context).add(GetLocationEvent());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.withOpacity(0.7),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(90), topRight: Radius.circular(90)),
            ),
          ),
          child: const Text(
            'Get Weather For Current Location',
            style: TextStyle(color: Color.fromARGB(255, 0, 33, 60), fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}