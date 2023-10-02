// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TipModel {
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnail;

  TipModel({
    this.id,
    this.title,
    this.url,
    this.thumbnail,
  });



  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnail: json['thumbnail'],
    );
  }
}
