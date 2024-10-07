abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final Exception error; 

  AuthFailure({required this.error});
}