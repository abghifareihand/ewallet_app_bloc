import 'package:another_flushbar/flushbar.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message) {
  //Color backgroundColor = isSuccess ? greenColor : redColor; // Memilih warna berdasarkan isSuccess

  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor, // Menggunakan warna yang dipilih
    duration: const Duration(seconds: 2),
  ).show(context);
}
