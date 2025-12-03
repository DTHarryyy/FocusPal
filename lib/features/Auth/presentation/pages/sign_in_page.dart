import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/features/Auth/provider/user_information_provider.dart';
import 'package:practice/features/chat_bot/pages/chat_bot_pages.dart';
import 'package:practice/features/Auth/presentation/pages/sign_up_page.dart';
import 'package:practice/features/Auth/presentation/widgets/custom_filled_btn.dart';
import 'package:practice/features/Auth/presentation/widgets/custom_input.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    try {
      final auth = ref.read(authServiceProvider);

      await auth.signIn(email, password);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatBotPages()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                Text(
                  'Sign in',
                  style: GoogleFonts.outfit(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomInput(
                  controller: emailController,
                  hintText: "Enter email",
                  isPassword: false,
                ),
                CustomInput(
                  controller: passwordController,
                  hintText: "Enter password",
                  isPassword: true,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text("Don't have an account?"),
                ),
                CustomFilledBtn(action: () => login(), btnText: 'Sign In'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
