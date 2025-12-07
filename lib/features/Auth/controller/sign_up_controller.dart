import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/features/Auth/model/app_user.dart';
import 'package:practice/features/Auth/provider/auth_provider.dart';

class SignUpController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async => null;

  Future<void> signUp(String email, String password, String usernmae) async {
    state = const AsyncValue.loading();

    final signUpUseCase = ref.read(signUpUseCaseProvider);
    final saveUserUseCase = ref.read(saveUseCaseProvider);

    state = await AsyncValue.guard(() async {
      //creatte accout user in firebase auth
      final user = await signUpUseCase(email, password);

      final updatedUser =
          AppUser(uid: user.uid, email: user.email, userName: usernmae);

      await saveUserUseCase(updatedUser);
      return updatedUser;
    });
  }
}

final signUpControllerProvider =
    AsyncNotifierProvider<SignUpController, AppUser?>(SignUpController.new);
