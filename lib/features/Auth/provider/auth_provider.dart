import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/features/Auth/repository/auth_credential_repository.dart';
import 'package:practice/features/Auth/use%20case/auth_use_case.dart';

final authReposutoryProvider = Provider((ref) => AuthCredentialRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

final signInUseCaseProvider = Provider(
    (ref) => SignInUseCase(repository: ref.read(authReposutoryProvider)));
final signUpUseCaseProvider = Provider(
    (ref) => SignUpUseCase(repository: ref.read(authReposutoryProvider)));
final saveUseCaseProvider = Provider(
    (ref) => SaveUserDataUseCase(repository: ref.read(authReposutoryProvider)));
