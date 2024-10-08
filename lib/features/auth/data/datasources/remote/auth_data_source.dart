import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationDataSource {
  Future<UserCredential> signUp(String fullName, String email, String password);
  Future<UserCredential> logIn(String email, String password);
}