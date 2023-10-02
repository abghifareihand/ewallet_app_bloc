import 'dart:convert';

import 'package:ewallet_app/common/constants.dart';
import 'package:ewallet_app/data/models/tip_model.dart';
import 'package:ewallet_app/data/services/local_service.dart';
import 'package:http/http.dart' as http;

class TipService {
  Future<List<TipModel>> getTips() async {
    try {
      final token = await LocalService().getToken();
      final response = await http.get(
        Uri.parse(
          '$baseUrl/tips',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        return List<TipModel>.from(
          jsonDecode(response.body)['data'].map(
            (tip) => TipModel.fromJson(tip),
          ),
        ).toList();
      }

      throw jsonDecode(response.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
