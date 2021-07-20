import 'package:firebase_auth/firebase_auth.dart';

Class Auth{
  final Firebase auth;
  // constructor

  Auth(this.auth);

  Stream<User> get user => auth.authStateChanges();

  Future<String> createAccount({String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword{
        email: email.trim(),
        password: password.trim(),
      }
    }
  }
}