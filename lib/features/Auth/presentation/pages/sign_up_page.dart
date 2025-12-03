import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/features/Auth/presentation/pages/sign_in_page.dart';
import 'package:practice/features/Auth/presentation/widgets/custom_filled_btn.dart';
import 'package:practice/features/Auth/presentation/widgets/custom_input.dart';
import 'package:practice/features/Auth/provider/user_information_provider.dart';
import 'package:practice/features/Auth/service/auth_firestore_service.dart';
import 'package:practice/features/chat_bot/pages/chat_bot_pages.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void createAccount() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();
    final confm = confirmPasswordController.text.trim();

    if (pass != confm) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("incorrect passowrd")));
      return;
    }

    try {
      final auth = ref.read(authServiceProvider);
      final firestore = ref.read(authFirestoreProvider);
      final userCred = await auth.signUp(email, pass);
      ref.read(userCredentialProvider.notifier).state = userCred;

      final user = userCred.user!;
      await firestore.addUserInformation(username, user.uid, email);
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatBotPages()));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
                  'Sign up',
                  style: GoogleFonts.outfit(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomInput(
                  controller: usernameController,
                  hintText: "Enter username",
                  isPassword: false,
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
                CustomInput(
                  controller: confirmPasswordController,
                  hintText: "Confirm password",
                  isPassword: true,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text('Already have an account?'),
                ),
                CustomFilledBtn(
                  action: () => createAccount(),
                  btnText: 'Sign In',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
