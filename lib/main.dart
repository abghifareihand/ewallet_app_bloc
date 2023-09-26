import 'package:ewallet_app/presentation/pages/login_page.dart';
import 'package:ewallet_app/presentation/pages/onboarding_page.dart';
import 'package:ewallet_app/presentation/pages/register_page.dart';
import 'package:ewallet_app/presentation/pages/register_set_ktp_page.dart';
import 'package:ewallet_app/presentation/pages/register_set_profile_page.dart';
import 'package:ewallet_app/presentation/pages/register_success_page.dart';
import 'package:ewallet_app/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/register-set-profile': (context) => const RegisterSetProfilePage(),
        '/register-set-ktp': (context) => const RegisterSetKtpPage(),
        '/register-success': (context) => const RegisterSuccessPage(),
      },
    );
  }
}
