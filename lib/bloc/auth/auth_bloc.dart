import 'package:equatable/equatable.dart';
import 'package:ewallet_app/data/models/login_model.dart';
import 'package:ewallet_app/data/models/register_model.dart';
import 'package:ewallet_app/data/models/user_edit_model.dart';
import 'package:ewallet_app/data/models/user_model.dart';
import 'package:ewallet_app/data/services/auth_service.dart';
import 'package:ewallet_app/data/services/local_service.dart';
import 'package:ewallet_app/data/services/user_service.dart';
import 'package:ewallet_app/data/services/wallet_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // Cek email udah terdaftar
      if (event is AuthCheckEmail) {
        try {
          emit(AuthLoading());
          final result = await AuthService().checkEmail(event.email);
          if (result == false) {
            emit(AuthCheckEmailSuccess());
          } else {
            emit(const AuthFailed('Email sudah terpakai'));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      // Register lempar data ke backend
      if (event is AuthRegister) {
        try {
          emit(AuthLoading());
          final user = await AuthService().register(event.data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      // Login lempar data ke backend
      if (event is AuthLogin) {
        try {
          emit(AuthLoading());
          final user = await AuthService().login(event.data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      // Get user
      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());
          final LoginModel data = await LocalService().getCredentialFromLocal();
          final UserModel user = await AuthService().login(data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      // Update user
      if (event is AuthUpdateUser) {
        try {
          if (state is AuthSuccess) {
            final updateUser = (state as AuthSuccess).user.copyWith(
                  username: event.data.username,
                  name: event.data.name,
                  email: event.data.email,
                  password: event.data.password,
                );
            emit(AuthLoading());
            await UserService().updateUser(event.data);

            emit(AuthSuccess(updateUser));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      // Update PIN
      if (event is AuthUpdatePin) {
        try {
          if (state is AuthSuccess) {
            final updateUser = (state as AuthSuccess).user.copyWith(
                  pin: event.newPin,
                );
            emit(AuthLoading());
            await WalletService().updatePin(event.oldPin, event.newPin);

            emit(AuthSuccess(updateUser));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      // Logout user
      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthService().logout();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      // Update balance
      if (event is AuthUpdateBalance) {
        if (state is AuthSuccess) {
          final currentUser = (state as AuthSuccess).user;
          final updateBalance = currentUser.copyWith(
              balance: currentUser.balance! + event.amount);

          emit(AuthSuccess(updateBalance));
        }
      }
    });
  }
}
