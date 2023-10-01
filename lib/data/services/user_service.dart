import 'dart:convert';

import 'package:ewallet_app/common/constants.dart';
import 'package:ewallet_app/data/models/user_edit_model.dart';
import 'package:ewallet_app/data/models/user_model.dart';
import 'package:ewallet_app/data/services/local_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<void> updateUser(UserEditModel data) async {
    try {
      final token = await LocalService().getToken();

      final response = await http.put(
        Uri.parse(
          '$baseUrl/users',
        ),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (response.statusCode != 200) {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getRecentUsers() async {
    try {
      final token = await LocalService().getToken();
      final response = await http.get(
        Uri.parse(
          '$baseUrl/transfer_histories',
        ),
        headers: {
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        return List<UserModel>.from(
          jsonDecode(response.body)['data'].map(
            (user) => UserModel.fromJson(user),
          ),
        );
      }

      throw jsonDecode(response.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getRecentUsersByUsername(String username) async {
    try {
      final token = await LocalService().getToken();
      final response = await http.get(
        Uri.parse(
          '$baseUrl/users/$username',
        ),
        headers: {
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        return List<UserModel>.from(
          jsonDecode(response.body).map(
            (user) => UserModel.fromJson(user),
          ),
        );
      }
      throw jsonDecode(response.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
