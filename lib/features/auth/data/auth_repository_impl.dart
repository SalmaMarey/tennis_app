import 'package:firebase_auth/firebase_auth.dart';
import 'package:tennis_app/features/auth/data/datasources/remote/auth_data_source.dart';
import 'package:tennis_app/features/auth/domain/auth_repository.dart';


class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource _dataSource;

  AuthenticationRepositoryImpl(this._dataSource);

  @override
  Future<UserCredential> signUp(String fullName, String email, String password) {
    return _dataSource.signUp(fullName, email, password);
  }

  @override
  Future<UserCredential> logIn(String email, String password) {
    return _dataSource.logIn(email, password);
  }
}
