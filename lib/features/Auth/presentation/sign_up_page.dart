import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/features/Auth/presentation/sign_in_page.dart';
import 'package:practice/features/Auth/presentation/widgets/custom_filled_btn.dart';
import 'package:practice/features/Auth/presentation/widgets/custom_input.dart';
import 'package:practice/features/Auth/service/auth_service.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
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
      await auth.signUp(email, pass);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Account Succesfully created")));
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
