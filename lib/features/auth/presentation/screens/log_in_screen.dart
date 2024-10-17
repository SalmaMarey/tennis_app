// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_app/core/di.dart';
import 'package:tennis_app/core/error/error_handler.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_event.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_state.dart';
import 'package:tennis_app/features/location/data/location_weather_repo_impl.dart';
import '../../../location/data/datasources/remote/location_weather_data_source.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(200, 0, 87, 166),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthSuccess) {
            final locationDataSource = getIt<LocationWeatherDataSource>();
            final locationRepo = LocationWeatherRepositoryImpl(
              locationDataSource,
            );
            try {
              final position = await locationRepo.getCurrentLocation();

              Navigator.of(context).pushReplacementNamed(
                '/locationweather',
                arguments: {
                  'latitude': position.latitude,
                  'longitude': position.longitude,
                },
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error fetching location: $e')),
              );
            }
          } else if (state is AuthFailure) {
            final failure = ErrorHandler.handleError(state.error);
            ErrorHandler.showErrorDialog(context, failure.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(screenSize.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.1),
                Center(
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width * 0.1,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'JOIN TODAY',
                    style: TextStyle(
                        fontSize: screenSize.width * 0.05, color: Colors.white),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.05),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.05),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(255, 128, 140, 165),
                  ),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.01),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.05),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(255, 128, 140, 165),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.005),
                Padding(
                  padding: EdgeInsets.only(left: screenSize.width * 0.53),
                  child: Text(
                    'Forget your password?',
                    style: TextStyle(
                        fontSize: screenSize.width * 0.036,
                        color: Colors.white),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.1),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();

                      if (!email.contains('@')) {
                        _showError(
                            context, 'Please enter a valid email address.');
                      } else if (password.length < 6) {
                        _showError(context,
                            'Password must be at least 6 characters long.');
                      } else {
                        BlocProvider.of<AuthBloc>(context).add(
                          LogInButtonPressed(
                            email: email,
                            password: password,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 8, 36, 59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      minimumSize: Size(screenSize.width * 0.7, 50),
                    ),
                    child: Text(
                      'LOG IN',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.06,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                    child: Text(
                      "DON'T HAVE AN ACCOUNT",
                      style: TextStyle(
                          fontSize: screenSize.width * 0.04,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
