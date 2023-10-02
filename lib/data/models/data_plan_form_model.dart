// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataPlanFormModel {
  final int? dataPlanId;
  final String? phoneNumber;
  final String? pin;

  DataPlanFormModel({
    this.dataPlanId,
    this.phoneNumber,
    this.pin,
  });

  // Request body
  Map<String, dynamic> toJson() {
    return{
      'data_plan_id': dataPlanId.toString(),
      'phone_number': phoneNumber,
      'pin': pin,
    };
  }
}
