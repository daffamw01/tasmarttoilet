import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel {
  final DateTime date;
  final String fullName;
  final String uid;
  final String presensi;
  ScheduleModel(
      {required this.date,
      required this.fullName,
      required this.uid,
      required this.presensi});

  factory ScheduleModel.fromFirestore(Map<String, dynamic> data) {
    return ScheduleModel(
        date: (data['date'] as Timestamp).toDate(),
        fullName: data['fullName'],
        uid: data['uid'],
        presensi: data['presensi']);
  }
  Map<String, Object?> toFirestore() {
    return {
      "date": Timestamp.fromDate(date),
      "fullName": fullName,
      "uid": uid,
      "presensi": presensi
    };
  }
}
