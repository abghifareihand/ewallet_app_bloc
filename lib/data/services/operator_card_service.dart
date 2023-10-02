import 'dart:convert';

import 'package:ewallet_app/common/constants.dart';
import 'package:ewallet_app/data/models/operator_card_model.dart';
import 'package:ewallet_app/data/services/local_service.dart';
import 'package:http/http.dart' as http;

class OperatorCardService {
  Future<List<OperatorCardModel>> getOperatorCards() async {
    try {
      final token = await LocalService().getToken();

      final response = await http.get(
        Uri.parse(
          '$baseUrl/operator_cards',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        return List<OperatorCardModel>.from(
          jsonDecode(response.body)['data'].map(
            (operatorCard) => OperatorCardModel.fromJson(operatorCard),
          ),
        ).toList();
      }
      throw jsonDecode(response.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
