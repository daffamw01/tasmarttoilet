import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String email;
  String fullName;
  String phoneNumber;
  String position;
  String profileImage;
  String uid;

  UserModel({
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.position,
    required this.profileImage,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        position: json["position"],
        profileImage: json["profileImage"] ?? '',
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "position": position,
        "profileImage": profileImage,
        "uid": uid,
      };
}
