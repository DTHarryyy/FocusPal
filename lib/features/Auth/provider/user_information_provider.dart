import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:practice/features/Auth/service/auth_service.dart';

/// 1️⃣ FirebaseAuth instance as a provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final userCredentialProvider = StateProvider<UserCredential?>((ref) => null);

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});
final authServiceProvider = Provider<AuthService>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  return AuthService(auth);
});
