// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tennis_app/core/error/error_handler.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_bloc.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_state.dart';
import 'package:tennis_app/features/auth/presentation/widgets/confirmed_dialog.dart';
import 'package:tennis_app/features/location/domain/location_weather_repo.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(200, 0, 87, 166),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
           
            final locationRepo = GetIt.instance<LocationWeatherRepository>();
            locationRepo.getCurrentLocation().then((position) {
              Navigator.of(context).pushReplacementNamed(
                '/locationweather',
                arguments: {
                  'latitude': position.latitude,
                  'longitude': position.longitude,
                },
              );
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error fetching location: $error')),
              );
            });
          } else if (state is AuthFailure) {
              final failure = ErrorHandler.handleError(state.error);
          ErrorHandler.showErrorDialog(context, failure.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'CREATE AN ACCOUNT TO USE OUR APP',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 50),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'FULL NAME',
                    style: TextStyle(
                      fontSize: 18,
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
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 18,
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
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 18,
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
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 10.0,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 60),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (fullNameController.text.length < 3) {
                        _showDialog(context,
                            'Full name must be at least 3 characters long.');
                      } else if (!emailController.text.contains('@')) {
                        _showDialog(
                            context, 'Please enter a valid email address.');
                      } else if (passwordController.text.length < 6) {
                        _showDialog(context,
                            'Password must be at least 6 characters long.');
                      } else {
                        showConfirmationDialog(
                          context: context,
                          fullNameController: fullNameController,
                          emailController: emailController,
                          passwordController: passwordController,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 8, 36, 59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      minimumSize: const Size(285, 50),
                    ),
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                    child: const Text(
                      'HAVE AN ACCOUNT?',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                // if (state is AuthLoading) const CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            AlertDialog(
              title: const Text(
                'Error',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 8, 36, 59),
                ),
              ),
              content: Text(
                message,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 8, 36, 59),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 8, 36, 59),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Positioned(
              left: 160,
              top: 230,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 8, 36, 59),
                    border: Border.all(color: Colors.white, width: 7)),
                child: const Icon(
                  Icons.error,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
