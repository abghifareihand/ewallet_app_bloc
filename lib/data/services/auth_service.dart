import 'dart:convert';
import 'package:ewallet_app/common/constants.dart';
import 'package:ewallet_app/data/models/login_model.dart';
import 'package:ewallet_app/data/models/register_model.dart';
import 'package:ewallet_app/data/models/user_model.dart';
import 'package:ewallet_app/data/services/local_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> checkEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/is-email-exist',
        ),
        body: {
          'email': email,
        },
      );

      print('checkEmail : ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['is_email_exist'];
      } else {
        return jsonDecode(response.body)['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> register(RegisterModel data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: data.toJson(),
      );
      print('checkRegister : ${response.body}');

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(response.body));
        user = user.copyWith(password: data.password);

        await LocalService().storeCredentialToLocal(user);

        return user;
      } else {
        // pake throw biar di tangkap di bloc nya
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(LoginModel data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: data.toJson(),
      );
      print('checkLogin : ${response.body}');

      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(response.body));
        user = user.copyWith(password: data.password);

        await LocalService().storeCredentialToLocal(user);

        return user;
      } else {
        // pake throw biar di tangkap di bloc nya
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
