class UserModel {
  late String uid;
  late String fullName;
  late String email;
  late String position;
  late String phoneNumber;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.position,
    required this.phoneNumber,
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      position: map['position'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
