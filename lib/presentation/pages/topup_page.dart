import 'package:ewallet_app/bloc/auth/auth_bloc.dart';
import 'package:ewallet_app/bloc/payment_method/payment_method_bloc.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/data/models/payment_method_model.dart';
import 'package:ewallet_app/data/models/topup_form_model.dart';
import 'package:ewallet_app/presentation/pages/topup_amount_page.dart';
import 'package:ewallet_app/presentation/widgets/bank_item.dart';
import 'package:ewallet_app/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopupPage extends StatefulWidget {
  const TopupPage({super.key});

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  PaymentMethodModel? selectedPayment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
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
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Text(
            'Wallet',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Row(
                  children: [
                    Image.asset(
                      'assets/img_wallet.png',
                      width: 80,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.cardNumber.toString().replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          '${state.user.name}',
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(
            'Select Bank',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          BlocProvider(
            create: (context) => PaymentMethodBloc()..add(GetPaymentMethod()),
            child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                if (state is PaymentMethodSuccess) {
                  return Column(
                      children: state.paymentMethod.map((payment) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPayment = payment;
                        });
                      },
                      child: BankItem(
                        paymentMethod: payment,
                        isSelected: payment.id == selectedPayment?.id,
                      ),
                    );
                  }).toList());
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          // ga bisa klik kalau belum select bank
        ],
      ),
      floatingActionButton: (selectedPayment != null)
          ? Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopupAmountPage(
                        data: TopupFormModel(
                          paymentMethodCode: selectedPayment?.code,
                        ),
                      ),
                    ),
                  );
                  //print('Selected Bank: ${selectedPayment?.code}');
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
