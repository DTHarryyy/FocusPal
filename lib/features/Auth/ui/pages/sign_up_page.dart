import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/features/Auth/controller/sign_up_controller.dart';
import 'package:practice/features/Auth/ui/pages/sign_in_page.dart';
import 'package:practice/features/Auth/ui/widgets/custom_filled_btn.dart';
import 'package:practice/features/Auth/ui/widgets/custom_input.dart';
import 'package:practice/features/chat_bot/ui/pages/chat_bot_pages.dart';

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

  void createAccount(SignUpController controller) async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final pass = passwordController.text.trim();
    final confm = confirmPasswordController.text.trim();

    if (username.isEmpty || email.isEmpty || pass.isEmpty || confm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }
    if (pass != confm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }
    await controller.signUp(email, pass, username);
    
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ChatBotPages()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpController = ref.watch(signUpControllerProvider.notifier);
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
                  action: () => createAccount(signUpController),
                  btnText: 'Sign Up',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
