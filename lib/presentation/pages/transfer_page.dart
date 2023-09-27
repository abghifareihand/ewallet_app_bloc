import 'package:ewallet_app/common/theme.dart';
import 'package:ewallet_app/presentation/widgets/custom_button.dart';
import 'package:ewallet_app/presentation/widgets/custom_form_field.dart';
import 'package:ewallet_app/presentation/widgets/transfer_recent_user_item.dart';
import 'package:ewallet_app/presentation/widgets/transfer_result_user_item.dart';
import 'package:flutter/material.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Text(
            'Search',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          const CustomFormField(
            title: 'by username',
            isShowTitle: false,
          ),
          //buildRecentUsers(),
          buildResult(),
          const SizedBox(
            height: 274.0,
          ),
          CustomFilledButton(
            title: 'Continue',
            onPressed: () {
              Navigator.pushNamed(context, '/transfer-amount');
            },
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }

  Widget buildRecentUsers() {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Users',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          const TransferRecentUserItem(
            imageUrl: 'assets/img_friend_1.png',
            name: 'Yonna Jie',
            username: 'yoenna',
            isVerified: true,
          ),
          const TransferRecentUserItem(
            imageUrl: 'assets/img_friend_2.png',
            name: 'Jani',
            username: 'janibos',
          ),
          const TransferRecentUserItem(
            imageUrl: 'assets/img_friend_3.png',
            name: 'John Hi',
            username: 'jhi',
          ),
        ],
      ),
    );
  }

  Widget buildResult() {
    return Container(
      margin: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Result',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 14.0,
          ),
          const Wrap(
            spacing: 17,
            runSpacing: 17,
            children: [
              TransferResultUserItem(
                imageUrl: 'assets/img_friend_1.png',
                name: 'Yonna Jie',
                username: 'yoenna',
                isVerified: true,
                isSelected: true,
              ),
              TransferResultUserItem(
                imageUrl: 'assets/img_friend_2.png',
                name: 'Jani',
                username: 'janibos',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
