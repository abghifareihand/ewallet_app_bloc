import 'package:equatable/equatable.dart';
import 'package:ewallet_app/data/models/transaction_model.dart';
import 'package:ewallet_app/data/services/transaction_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) async {
      if (event is GetTransaction) {
        try {
          emit(TransactionLoading());
          final transaction = await TransactionService().getTransactions();
          emit(TransactionSuccess(transaction));
        } catch (e) {
          emit(TransactionFailed(e.toString()));
        }
      }
    });
  }
}
