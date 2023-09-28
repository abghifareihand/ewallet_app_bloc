import 'package:ewallet_app/bloc/auth/auth_bloc.dart';
import 'package:ewallet_app/common/snackbar.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/data/models/register_model.dart';
import 'package:ewallet_app/presentation/pages/register_set_profile_page.dart';
import 'package:ewallet_app/presentation/widgets/custom_button.dart';
import 'package:ewallet_app/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  bool isHide = true;

  bool validate() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          Container(
            width: 155,
            height: 50,
            margin: const EdgeInsets.only(
              top: 100,
              bottom: 100,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo_light.png'),
              ),
            ),
          ),
          Text(
            'Register to Unlock\nGrow Your Finance',
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                /// Name
                CustomFormField(
                  title: 'Name',
                  controller: nameController,
                ),
                const SizedBox(
                  height: 16.0,
                ),

                /// Email Address
                CustomFormField(
                  title: 'Email Address',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16.0,
                ),

                /// Password
                CustomFormField(
                  title: 'Password',
                  controller: passwordController,
                  obscureText: isHide,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isHide = !isHide;
                      });
                    },
                    icon: Icon(
                      isHide
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailed) {
                      showCustomSnackbar(context, state.error);
                    }

                    if (state is AuthCheckEmailSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterSetProfilePage(
                            data: RegisterModel(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomFilledButton(
                      title: state is AuthLoading ? 'Loading...' : 'Continue',
                      onPressed: () {
                        if (validate()) {
                          context
                              .read<AuthBloc>()
                              .add(AuthCheckEmail(emailController.text));
                        } else {
                          showCustomSnackbar(
                              context, 'Semua field harus di isi !!');
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          CustomTextbutton(
            title: 'Login',
            onPressed: () {},
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
