import 'package:ewallet_app/common/currency.dart';
import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/data/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeLatestTransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const HomeLatestTransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Row(
        children: [
          Image.asset(
            transaction.transactionType!.code == 'internet'
                ? 'assets/ic_transaction_electric.png'
                : transaction.transactionType!.code == 'top_up'
                    ? 'assets/ic_transaction_topup.png'
                    : transaction.transactionType!.code == 'transfer'
                        ? 'assets/ic_transaction_transfer.png'
                        : transaction.transactionType!.code == 'receive'
                            ? 'assets/ic_transaction_cashback.png'
                            : 'assets/ic_transaction_withdraw.png',
            width: 48,
          ),
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.transactionType!.name.toString(),
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  DateFormat('MMM dd, yyyy')
                      .format(transaction.createdAt ?? DateTime.now()),
                  style: greyTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatCurrency(
              transaction.amount ?? 0,
              symbol: transaction.transactionType?.action == 'cr' ? '+ ' : '- ',
            ),
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }
}
