import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/features/Auth/model/app_user.dart';
import 'package:practice/features/Auth/provider/auth_provider.dart';

class SignUpController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async => null;

  Future<void> signUp(String email, String password, String username) async {
    state = const AsyncValue.loading();

    final signUpUseCase = ref.read(signUpUseCaseProvider);
    final saveUserUseCase = ref.read(saveUseCaseProvider);

    state = await AsyncValue.guard(() async {

      final user = await signUpUseCase(email, password);

      final newUser =
          AppUser(uid: user.uid, email: email, userName: username);

      await saveUserUseCase(newUser);

      return newUser;
    });
  }
}

final signUpControllerProvider =
    AsyncNotifierProvider<SignUpController, AppUser?>(SignUpController.new);
