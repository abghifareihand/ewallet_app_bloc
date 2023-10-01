import 'dart:convert';

import 'package:ewallet_app/common/constants.dart';
import 'package:ewallet_app/data/models/topup_form_model.dart';
import 'package:ewallet_app/data/models/transfer_fomr_model.dart';
import 'package:ewallet_app/data/services/local_service.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  Future<String> topUp(TopupFormModel data) async {
    try {
      final token = await LocalService().getToken();
      final response = await http.post(
        Uri.parse(
          '$baseUrl/top_ups',
        ),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['redirect_url'];
      }
      throw jsonDecode(response.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> transfer(TransferFormModel data) async {
    try {
      final token = await LocalService().getToken();
      final response = await http.post(
        Uri.parse(
          '$baseUrl/transfers',
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
}
