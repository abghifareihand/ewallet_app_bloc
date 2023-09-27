import 'package:ewallet_app/presentation/pages/data_package_page.dart';
import 'package:ewallet_app/presentation/pages/data_provider_page.dart';
import 'package:ewallet_app/presentation/pages/data_success_page.dart';
import 'package:ewallet_app/presentation/pages/topup_amount_page.dart';
import 'package:ewallet_app/presentation/pages/topup_page.dart';
import 'package:ewallet_app/presentation/pages/topup_success_page.dart';
import 'package:ewallet_app/presentation/pages/transfer_amount_page.dart';
import 'package:ewallet_app/presentation/pages/transfer_page.dart';
import 'package:ewallet_app/presentation/pages/transfer_success_page.dart';
import 'package:flutter/material.dart';
import 'package:ewallet_app/presentation/pages/pin_page.dart';
import 'package:ewallet_app/presentation/pages/profile_edit_page.dart';
import 'package:ewallet_app/presentation/pages/profile_edit_pin_page.dart';
import 'package:ewallet_app/presentation/pages/profile_edit_success_page.dart';
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

      /// Register
      '/register': (context) => const RegisterPage(),
      '/register-set-profile': (context) => const RegisterSetProfilePage(),
      '/register-set-ktp': (context) => const RegisterSetKtpPage(),
      '/register-success': (context) => const RegisterSuccessPage(),

      '/home': (context) => const HomePage(),
      '/pin': (context) => const PinPage(),

      /// Profile
      '/profile': (context) => const ProfilePage(),
      '/profile-edit': (context) => const ProfileEditPage(),
      '/profile-edit-pin': (context) => const ProfileEditPinPage(),
      '/profile-edit-success': (context) => const ProfileEditSuccessPage(),

      /// Topup
      '/topup': (context) => const TopupPage(),
      '/topup-amount': (context) => const TopupAmountPage(),
      '/topup-success': (context) => const TopupSuccessPage(),

      /// Transfer
      '/transfer': (context) => const TransferPage(),
      '/transfer-amount': (context) => const TransferAmountPage(),
      '/transfer-success': (context) => const TransferSuccessPage(),

      /// Data 
      '/data-provider': (context) => const DataProviderPage(),
      '/data-package': (context) => const DataPackagePage(),
      '/data-success': (context) => const DataSuccessPage(),
    };
  }
}
