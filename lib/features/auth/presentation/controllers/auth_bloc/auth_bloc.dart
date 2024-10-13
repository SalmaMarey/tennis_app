import 'package:bloc/bloc.dart';

import 'package:tennis_app/features/auth/domain/use_case/log_in.dart';
import 'package:tennis_app/features/auth/domain/use_case/sign_up.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final LogInUseCase logInUseCase;

  AuthBloc({
    required this.signUpUseCase,
    required this.logInUseCase,
  }) : super(AuthInitial()) {
    on<SignUpButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        await signUpUseCase.execute(
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        );
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(error: e as Exception));
      }
    });

    on<LogInButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        await logInUseCase.execute(
          email: event.email,
          password: event.password,
        );
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(error: e as Exception));
      }
    });
  }
}
