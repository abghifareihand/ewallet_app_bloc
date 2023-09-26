import 'package:ewallet_app/presentation/pages/pin_page.dart';
import 'package:ewallet_app/presentation/pages/profile_edit_page.dart';
import 'package:ewallet_app/presentation/pages/profile_edit_pin_page.dart';
import 'package:ewallet_app/presentation/pages/profile_edit_success_page.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/presentation/pages/home_page.dart';
import 'package:ewallet_app/presentation/pages/login_page.dart';
import 'package:ewallet_app/presentation/pages/onboarding_page.dart';
import 'package:ewallet_app/presentation/pages/profile_page.dart';
import 'package:ewallet_app/presentation/pages/register_page.dart';
import 'package:ewallet_app/presentation/pages/register_set_ktp_page.dart';
import 'package:ewallet_app/presentation/pages/register_set_profile_page.dart';
import 'package:ewallet_app/presentation/pages/register_success_page.dart';
import 'package:ewallet_app/presentation/pages/splash_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const SplashPage(),
      '/onboarding': (context) => const OnboardingPage(),
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/register-set-profile': (context) => const RegisterSetProfilePage(),
      '/register-set-ktp': (context) => const RegisterSetKtpPage(),
      '/register-success': (context) => const RegisterSuccessPage(),
      '/home': (context) => const HomePage(),
      '/profile': (context) => const ProfilePage(),
      '/pin': (context) => const PinPage(),
      '/profile-edit': (context) => const ProfileEditPage(),
      '/profile-edit-pin': (context) => const ProfileEditPinPage(),
      '/profile-edit-success': (context) => const ProfileEditSuccessPage(),
    };
  }
}
