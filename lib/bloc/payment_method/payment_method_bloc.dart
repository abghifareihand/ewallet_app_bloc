import 'package:equatable/equatable.dart';
import 'package:ewallet_app/data/models/payment_method_model.dart';
import 'package:ewallet_app/data/services/payment_method_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodInitial()) {
    on<PaymentMethodEvent>((event, emit) async {
      if (event is GetPaymentMethod) {
        try {
          emit(PaymentMethodLoading());
          final payment = await PaymentMethodService().getPaymentMethods();
          emit(PaymentMethodSuccess(payment));
        } catch (e) {
          emit(PaymentMethodFailed(e.toString()));
        }
      }
    });
  }
}
