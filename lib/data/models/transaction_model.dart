import 'package:ewallet_app/data/models/payment_method_model.dart';
import 'package:ewallet_app/data/models/transaction_type_model.dart';

class TransactionModel {
  final int? id;
  final int? amount;
  final DateTime? createdAt;
  final PaymentMethodModel? paymentMethod;
  final TransactionTypeModel? transactionType;

  TransactionModel({
    this.id,
    this.amount,
    this.createdAt,
    this.paymentMethod,
    this.transactionType,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      amount: json['amount'],
      createdAt: DateTime.tryParse(json['created_at']),
      paymentMethod: json['payment_method'] == null
          ? null
          : PaymentMethodModel.fromJson(json['payment_method']),
      transactionType: json['transaction_type'] == null
          ? null
          : TransactionTypeModel.fromJson(json['transaction_type']),
    );
  }
}
