import 'package:ewallet_app/bloc/auth/auth_bloc.dart';
import 'package:ewallet_app/bloc/transfer/transfer_bloc.dart';
import 'package:ewallet_app/common/snackbar.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/data/models/transfer_fomr_model.dart';
import 'package:ewallet_app/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransferAmountPage extends StatefulWidget {
  final TransferFormModel data;
  const TransferAmountPage({
    super.key,
    required this.data,
  });

  @override
  State<TransferAmountPage> createState() => _TransferAmountPageState();
}

class _TransferAmountPageState extends State<TransferAmountPage> {
  final TextEditingController amountController =
      TextEditingController(text: '0');

  void addAmount(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
    });
  }

  void deleteAmount() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text
            .substring(0, amountController.text.length - 1);
        if (amountController.text == '') {
          amountController.text = '0';
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    amountController.addListener(() {
      final text = amountController.text;

      amountController.value = amountController.value.copyWith(
        text: NumberFormat.currency(
          locale: 'id',
          decimalDigits: 0,
          symbol: '',
        ).format(int.parse(text.replaceAll('.', ''))),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Center(
        child: BlocProvider(
          create: (context) => TransferBloc(),
          child: BlocConsumer<TransferBloc, TransferState>(
            listener: (context, state) {
              if (state is TransferFailed) {
                showCustomSnackbar(context, state.error);
              }
              if (state is TransferSuccess) {
                if (context.mounted) {
                  context.read<AuthBloc>().add(
                        AuthUpdateBalance(
                          int.parse(
                                amountController.text.replaceAll('.', ''),
                              ) *
                              -1,
                        ),
                      );

                  Navigator.pushNamedAndRemoveUntil(
                      context, '/transfer-success', (_) => false);
                }
              }
            },
            builder: (context, state) {
              if (state is TransferLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 58,
                ),
                children: [
                  const SizedBox(
                    height: 36.0,
                  ),
                  Center(
                    child: Text(
                      'Transfer Amount',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 67.0,
                  ),

                  /// Amount
                  Align(
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: amountController,
                        cursorColor: greyColor,
                        enabled: false,
                        style: whiteTextStyle.copyWith(
                          fontSize: 36,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Text(
                            'Rp ',
                            style: whiteTextStyle.copyWith(
                              fontSize: 36,
                              fontWeight: medium,
                            ),
                          ),
                          disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: greyColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 66.0,
                  ),
                  Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    children: [
                      CustomInputButton(
                        title: '1',
                        onTap: () {
                          addAmount('1');
                        },
                      ),
                      CustomInputButton(
                        title: '2',
                        onTap: () {
                          addAmount('2');
                        },
                      ),
                      CustomInputButton(
                        title: '3',
                        onTap: () {
                          addAmount('3');
                        },
                      ),
                      CustomInputButton(
                        title: '4',
                        onTap: () {
                          addAmount('4');
                        },
                      ),
                      CustomInputButton(
                        title: '5',
                        onTap: () {
                          addAmount('5');
                        },
                      ),
                      CustomInputButton(
                        title: '6',
                        onTap: () {
                          addAmount('6');
                        },
                      ),
                      CustomInputButton(
                        title: '7',
                        onTap: () {
                          addAmount('7');
                        },
                      ),
                      CustomInputButton(
                        title: '8',
                        onTap: () {
                          addAmount('8');
                        },
                      ),
                      CustomInputButton(
                        title: '9',
                        onTap: () {
                          addAmount('9');
                        },
                      ),
                      const SizedBox(
                        height: 60.0,
                        width: 60.0,
                      ),
                      CustomInputButton(
                        title: '0',
                        onTap: () {
                          addAmount('0');
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          deleteAmount();
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: numberBackgroundColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  CustomFilledButton(
                    title: 'Continue',
                    onPressed: () async {
                      if (await Navigator.pushNamed(context, '/pin') == true) {
                        if (!mounted) return;
                        final authState = context.read<AuthBloc>().state;
                        String pin = '';
                        if (authState is AuthSuccess) {
                          pin = authState.user.pin!;
                        }
                        context.read<TransferBloc>().add(
                              TransferPost(
                                widget.data.copyWith(
                                  pin: pin,
                                  amount:
                                      amountController.text.replaceAll('.', ''),
                                ),
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  CustomTextbutton(
                    title: 'Terms & Conditions',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
