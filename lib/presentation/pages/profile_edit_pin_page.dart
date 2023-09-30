import 'package:ewallet_app/bloc/auth/auth_bloc.dart';
import 'package:ewallet_app/common/snackbar.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/presentation/widgets/custom_button.dart';
import 'package:ewallet_app/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPinPage extends StatefulWidget {
  const ProfileEditPinPage({super.key});

  @override
  State<ProfileEditPinPage> createState() => _ProfileEditPinPageState();
}

class _ProfileEditPinPageState extends State<ProfileEditPinPage> {
  final oldPinController = TextEditingController(text: '');
  final newPinController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pin'),
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
                /// Old PIN
                CustomFormField(
                  title: 'Old PIN',
                  controller: oldPinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16.0,
                ),

                /// New PIN
                CustomFormField(
                  title: 'New PIN',
                  controller: newPinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 16.0,
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
                        context.read<AuthBloc>().add(
                              AuthUpdatePin(
                                oldPinController.text,
                                newPinController.text,
                              ),
                            );
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
