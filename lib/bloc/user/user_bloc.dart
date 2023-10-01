import 'package:equatable/equatable.dart';
import 'package:ewallet_app/data/models/user_model.dart';
import 'package:ewallet_app/data/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is GetUserByUsername) {
        try {
          emit(UserLoading());
          final users =
              await UserService().getRecentUsersByUsername(event.username);
          emit(UserSuccess(users));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }
      if (event is GetUserRecent) {
        try {
          emit(UserLoading());
          final users = await UserService().getRecentUsers();
          emit(UserSuccess(users));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }
    });
  }
}
