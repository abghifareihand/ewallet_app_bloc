
import 'package:equatable/equatable.dart';
import 'package:ewallet_app/data/models/operator_card_model.dart';
import 'package:ewallet_app/data/services/operator_card_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'operator_card_event.dart';
part 'operator_card_state.dart';

class OperatorCardBloc extends Bloc<OperatorCardEvent, OperatorCardState> {
  OperatorCardBloc() : super(OperatorCardInitial()) {
    on<OperatorCardEvent>((event, emit) async {
      if (event is GetOperatorCard) {
        try {
          emit(OperatorCardLoading());
          final operatorCards = await OperatorCardService().getOperatorCards();
          emit(OperatorCardSuccess(operatorCards));
        } catch (e) {
          emit(OperatorCardFailed(e.toString()));
        }
      }
    });
  }
}
