
import 'package:equatable/equatable.dart';
import 'package:ewallet_app/data/models/tip_model.dart';
import 'package:ewallet_app/data/services/tip_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tip_event.dart';
part 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  TipBloc() : super(TipInitial()) {
    on<TipEvent>((event, emit) async {
      if (event is GetTips) {
        try {
          emit(TipLoading());
          final tips = await TipService().getTips();
          emit(TipSuccess(tips));
        } catch (e) {
          emit(TipFailed(e.toString()));
        }
      }
    });
  }
}
