import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/features/auth/domain/auth_repository.dart';

class LogInUseCase {
  final AuthenticationRepository _authenticationRepository;

  LogInUseCase(this._authenticationRepository);

  Future<UserCredential> execute({
    required String email,
    required String password,
  }) async {
    return await _authenticationRepository.logIn(email, password);
  }
}