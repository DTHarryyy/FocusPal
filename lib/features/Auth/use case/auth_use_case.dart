import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/features/Auth/model/app_user.dart';
import 'package:practice/features/Auth/repository/auth_credential_repository.dart';

class SignInUseCase {
  final AuthCredentialRepository repository;
  SignInUseCase({required this.repository});

  Future<User> call(String email, String password) =>
      repository.signIn(email, password);
}

class SignUpUseCase {
  final AuthCredentialRepository repository;
  SignUpUseCase({required this.repository});

  Future<User> call(String email, String password) =>
      repository.signUp(email, password);
}

class SaveUserDataUseCase {
  final AuthCredentialRepository repository;
  SaveUserDataUseCase({required this.repository});

  Future<void> call(AppUser userCred) => repository.saveUserData(userCred);
}

class GetUserUserCase {
  final AuthCredentialRepository repository;
  GetUserUserCase({required this.repository});

  Future<AppUser> call(String uid) => repository.getUser(uid);
}
