import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/core/widgets/custom_loading.dart';
import 'package:practice/features/Auth/provider/auth_changes_provider.dart';
import 'package:practice/features/chat_bot/ui/pages/chat_bot_pages.dart';
import 'package:practice/features/Auth/ui/pages/sign_in_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return currentUser.when(
      data: (user) => user != null ? ChatBotPages() : SignInPage(),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
      loading: () => CustomLoading(),
    );
  }
}
