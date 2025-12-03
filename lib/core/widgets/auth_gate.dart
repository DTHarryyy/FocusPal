import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/core/widgets/custom_loading.dart';
import 'package:practice/features/Auth/provider/user_information_provider.dart';
import 'package:practice/features/chat_bot/pages/chat_bot_pages.dart';
import 'package:practice/features/Auth/presentation/pages/sign_in_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return ChatBotPages();
        } else {
          return SignInPage();
        }
      },
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Errpr: $error'))),
      loading: () => CustomLoading(),
    );
  }
}
