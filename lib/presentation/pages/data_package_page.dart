import 'package:ewallet_app/bloc/auth/auth_bloc.dart';
import 'package:ewallet_app/bloc/data_plan/data_plan_bloc.dart';
import 'package:ewallet_app/common/snackbar.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/data/models/data_plan_form_model.dart';
import 'package:ewallet_app/data/models/data_plan_model.dart';
import 'package:ewallet_app/data/models/operator_card_model.dart';
import 'package:ewallet_app/presentation/widgets/custom_button.dart';
import 'package:ewallet_app/presentation/widgets/custom_form_field.dart';
import 'package:ewallet_app/presentation/widgets/data_package_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataPackagePage extends StatefulWidget {
  final OperatorCardModel operatorCard;
  const DataPackagePage({
    super.key,
    required this.operatorCard,
  });

  @override
  State<DataPackagePage> createState() => _DataPackagePageState();
}

class _DataPackagePageState extends State<DataPackagePage> {
  final phoneController = TextEditingController(text: '');
  DataPlanModel? selectedDataPlan;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataPlanBloc(),
      child: BlocConsumer<DataPlanBloc, DataPlanState>(
        listener: (context, state) {
          if (state is DataPlanFailed) {
            showCustomSnackbar(context, state.error);
          }

          if (state is DataPlanSuccess) {
            if (context.mounted) {
              context.read<AuthBloc>().add(
                    AuthUpdateBalance(
                      selectedDataPlan!.price! * -1,
                    ),
                  );

              Navigator.pushNamedAndRemoveUntil(
                  context, '/data-success', (_) => false);
            }
          }
        },
        builder: (context, state) {
          if (state is DataPlanLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Paket Data'),
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
                Text(
                  'Phone Number',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                CustomFormField(
                  title: '+628',
                  controller: phoneController,
                  isShowTitle: false,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Select Package',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Wrap(
                  spacing: 17,
                  runSpacing: 17,
                  children: widget.operatorCard.dataPlans!.map((dataPlan) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDataPlan = dataPlan;
                        });
                      },
                      child: DataPackageItem(
                        dataPlan: dataPlan,
                        isSelected: dataPlan.id == selectedDataPlan?.id,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
            floatingActionButton:
                (selectedDataPlan != null && phoneController.text.isNotEmpty)
                    ? Container(
                        margin: const EdgeInsets.all(24),
                        child: CustomFilledButton(
                          title: 'Continue',
                          onPressed: () async {
                            if (await Navigator.pushNamed(context, '/pin') ==
                                true) {
                              if (!mounted) return;
                              final authState = context.read<AuthBloc>().state;
                              String pin = '';
                              if (authState is AuthSuccess) {
                                pin = authState.user.pin!;
                              }
                              context.read<DataPlanBloc>().add(
                                    DataPlanPost(
                                      DataPlanFormModel(
                                        dataPlanId: selectedDataPlan!.id,
                                        phoneNumber: phoneController.text,
                                        pin: pin,
                                      ),
                                    ),
                                  );
                            }
                          },
                        ),
                      )
                    : Container(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }
}
