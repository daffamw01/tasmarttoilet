// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

AppointmentModel appointmentModelFromJson(String str) =>
    AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) =>
    json.encode(data.toJson());

class AppointmentModel {
  Uid uid;

  AppointmentModel({
    required this.uid,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        uid: Uid.fromJson(json["uid"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid.toJson(),
      };
}

class Uid {
  String date;

  Uid({
    required this.date,
  });

  factory Uid.fromJson(Map<String, dynamic> json) => Uid(
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
      };

  DateTime getDateTime() {
    return DateTime.parse(date);
  }

  String getDateString() {
    return DateFormat('dd/MM/yyyy').format(getDateTime());
  }
}

// class AppointmentModel {
//   Date date;

//   AppointmentModel({
//     required this.date,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "date": date.toJson(),
//     };
//   }

//   factory AppointmentModel.fromJson(Map<String, dynamic> json) {
//     return AppointmentModel(
//       date: Date.fromJson(json["date"]),
//     );
//   }
// }

// class Date {
//   String fullName;

//   Date({
//     required this.fullName,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       "fullName": fullName,
//     };
//   }

//   factory Date.fromJson(Map<String, dynamic> json) {
//     return Date(
//       fullName: json["fullName"],
//     );
//   }
// }