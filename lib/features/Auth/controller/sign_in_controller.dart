import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/features/Auth/model/app_user.dart';
import 'package:practice/features/Auth/provider/auth_provider.dart';

class SignInController  extends AsyncNotifier<AppUser?>{
  @override
  Future<AppUser?> build() async => null;

  Future<void> signIn(String email, String password) async {
    state = AsyncValue.loading();

    final signInUseCase = ref.read(signInUseCaseProvider);
    final getUserUseCase = ref.read(getUserUseCaseProvider);

    state = await AsyncValue.guard(() async {
      final user = await signInUseCase(email, password);

      final userCred = await getUserUseCase(user.uid);

      return AppUser(uid: userCred.uid, email: userCred.email, userName: userCred.userName);
    });
  }
}