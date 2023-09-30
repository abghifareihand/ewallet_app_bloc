import 'package:ewallet_app/bloc/auth/auth_bloc.dart';
import 'package:ewallet_app/common/snackbar.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/data/models/user_edit_model.dart';
import 'package:ewallet_app/presentation/widgets/custom_button.dart';
import 'package:ewallet_app/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final usernameController = TextEditingController(text: '');
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  bool isHide = true;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      usernameController.text = authState.user.username!;
      nameController.text = authState.user.name!;
      emailController.text = authState.user.email!;
      passwordController.text = authState.user.password!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
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
                /// Username
                CustomFormField(
                  title: 'Username',
                  controller: usernameController,
                ),
                const SizedBox(
                  height: 16.0,
                ),

                /// Fullname
                CustomFormField(
                  title: 'Full Name',
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

                    if (state is AuthSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/profile-edit-success', (route) => false);
                    }
                  },
                  builder: (context, state) {
                    return CustomFilledButton(
                      title: state is AuthLoading ? 'Loading...' : 'Update Now',
                      onPressed: () {
                        final updateUser = UserEditModel(
                          username: usernameController.text,
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        context
                            .read<AuthBloc>()
                            .add(AuthUpdateUser(updateUser));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
