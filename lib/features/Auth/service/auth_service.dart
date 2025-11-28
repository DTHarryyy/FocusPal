import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/core/service/auth_service.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});
final authServiceProvider = Provider<AuthService>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  return AuthService(auth);
});

class AuthService {
  final FirebaseAuth auth;
  AuthService(this.auth);

  Stream<User?> authState() => auth.authStateChanges();

  Future<User?> signIn(String email, String password) async {
    final cred = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }

  Future<User?> signUp(String email, String password) async {
    final cred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return cred.user;
  }

  Future<void> logout() => auth.signOut();
}
