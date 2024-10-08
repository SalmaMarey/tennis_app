import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:tennis_app/core/error/error_failure.dart';

class WeatherException implements Exception {
  final String message;
  WeatherException(this.message);
}

class ErrorHandler {
  static ErrorFailure handleError(Exception e) {
    String message;
    int code;

    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          code = 404;
          break;
        case 'wrong-password':
          message = 'Incorrect password provided.';
          code = 401;
          break;
        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          code = 409;
          break;
        default:
          message = 'An unexpected error occurred. Please try again.';
          code = 500;
      }
    } else if (e is http.ClientException) {
      message = 'Network error. Please check your internet connection.';
      code = 503;
    } else if (e is WeatherException) {
      message = e.message;
      code = 422;
    } else {
      message = 'An unexpected error occurred: ${e.toString()}';
      code = 500;
    }

    return ErrorFailure(code, message);
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('An Error Occurred'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
