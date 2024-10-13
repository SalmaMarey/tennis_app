import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tennis_app/features/auth/data/models/user_model.dart';
import 'auth_data_source.dart';

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthenticationDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore;

  @override
  Future<UserCredential> signUp(String fullName, String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserModel userModel = UserModel(
      uid: userCredential.user!.uid,
      fullName: fullName,
      email: email,
    );

    await _firestore.collection('users').doc(userModel.uid).set(userModel.toMap());
    return userCredential;
  }

  @override
  Future<UserCredential> logIn(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }
}
