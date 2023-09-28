class RegisterModel {
  final String? name;
  final String? email;
  final String? password;
  final String? pin;
  final String? profilePicture;
  final String? ktp;

  RegisterModel({
    this.name,
    this.email,
    this.password,
    this.pin,
    this.profilePicture,
    this.ktp,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'pin': pin,
      'profile_picture': profilePicture,
      'ktp': ktp,
    };
  }

  // mempertahankan data yg lama, menambah data baru
  RegisterModel copyWith({
    String? pin,
    String? profilePicture,
    String? ktp,
  }) {
    return RegisterModel(
      name: name,
      email: email,
      password: password,
      pin: pin ?? this.pin,
      profilePicture: profilePicture ?? this.profilePicture,
      ktp: ktp ?? this.ktp,
    );
  }

}
