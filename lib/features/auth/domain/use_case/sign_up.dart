import 'package:tennis_app/features/auth/domain/auth_repository.dart';

class SignUpUseCase {
  final AuthenticationRepository _authenticationRepository;

  SignUpUseCase(this._authenticationRepository);

  Future<void> execute({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await _authenticationRepository.signUp(fullName, email, password);
  }
}