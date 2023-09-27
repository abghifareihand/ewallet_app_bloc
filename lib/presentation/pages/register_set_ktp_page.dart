import 'dart:convert';
import 'dart:io';

import 'package:ewallet_app/bloc/bloc/auth_bloc.dart';
import 'package:ewallet_app/common/currency.dart';
import 'package:ewallet_app/common/snackbar.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/data/models/register_model.dart';
import 'package:ewallet_app/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class RegisterSetKtpPage extends StatefulWidget {
  final RegisterModel data;
  const RegisterSetKtpPage({
    super.key,
    required this.data,
  });

  @override
  State<RegisterSetKtpPage> createState() => _RegisterSetKtpPageState();
}

class _RegisterSetKtpPageState extends State<RegisterSetKtpPage> {
  XFile? selectedImage;
  bool validate() {
    if (selectedImage == null) {
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
            'Verify Your\nAccount',
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
                /// Upload KTP
                GestureDetector(
                  onTap: () async {
                    final image = await selectImage();
                    setState(() {
                      selectedImage = image;
                    });
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightBackgroundColor,
                      image: selectedImage == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(selectedImage!.path),
                              ),
                            ),
                    ),
                    child: selectedImage != null
                        ? null
                        : Center(
                            child: Image.asset(
                              'assets/ic_upload.png',
                              width: 32,
                            ),
                          ),
                  ),
                ),

                /// Space
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Passport/ID Card',
                  style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailed) {
                      showCustomSnackbar(context, state.error);
                    }

                    if (state is AuthSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    }
                  },
                  builder: (context, state) {
                    return CustomFilledButton(
                      title: state is AuthLoading ? 'Loading...' : 'Continue',
                      onPressed: () {
                        if (validate()) {
                          context.read<AuthBloc>().add(
                                AuthRegister(
                                  widget.data.copyWith(
                                    ktp: selectedImage == null
                                        ? null
                                        : 'data:image/png;base64,${base64Encode(
                                            File(selectedImage!.path)
                                                .readAsBytesSync(),
                                          )}',
                                  ),
                                ),
                              );
                        } else {
                          showCustomSnackbar(
                              context, 'Gambar tidak boleh kosong');
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
            title: 'Skip for Now',
            onPressed: () {
              context.read<AuthBloc>().add(
                    AuthRegister(
                      widget.data,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
