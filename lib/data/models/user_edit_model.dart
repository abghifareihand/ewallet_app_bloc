// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserEditModel {
  final String? username;
  final String? name;
  final String? email;
  final String? password;

  UserEditModel({
    this.username,
    this.name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return{
      'username': username,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
