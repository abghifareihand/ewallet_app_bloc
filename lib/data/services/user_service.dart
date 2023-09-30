import 'dart:convert';

import 'package:ewallet_app/common/constants.dart';
import 'package:ewallet_app/data/models/user_edit_model.dart';
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
        body: data.toJson(),
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode != 200) {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
