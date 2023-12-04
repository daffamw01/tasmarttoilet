// import 'dart:async';
// import 'dart:convert';
// import 'dart:html';

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasmarttoilet/models/MonitoringModel.dart';

class GetData {
  static Stream getUsersPetugas() async* {
    final user = FirebaseAuth.instance.currentUser!;

    final databaseReference = FirebaseDatabase.instance.ref();
    final userRef = databaseReference.child("users").child(user.uid);
    final dataSnapshot = await userRef.once();

    yield dataSnapshot.snapshot.value;
  }

  // static Stream getUsersPegawai() async* {
  //   final user = FirebaseAuth.instance.currentUser!;

  //   final databaseReference = FirebaseDatabase.instance.ref();
  //   final userRef = databaseReference.child("users").child(user.uid);
  //   final dataSnapshot = await userRef.once();

  //   yield dataSnapshot.snapshot.value;
  // }

  // static Stream getMonitoring() async* {
  //   final databaseReference = FirebaseDatabase.instance.ref();
  //   final userRef = databaseReference.child("monitoring");
  //   final snapshot = await userRef.get();

  //   final map = snapshot.value as Map<dynamic, dynamic>;
  //   var data = [];
  //   for (var value in map.values) {
  //     if (value['bilik1'] == bilik1) {
  //       data.add(value);
  //     } else if (value['bilik2'] == bilik2) {
  //       data.add(value);
  //     }
  //   }
  //   yield data;
  // }

  static Stream getUsers({required String position}) async* {
    final databaseReference = FirebaseDatabase.instance.ref();
    final userRef = databaseReference.child("users");
    final snapshot = await userRef.get();
    // print('dataSnapshot :');
    // print(snapshot);

    final map = snapshot.value as Map<dynamic, dynamic>;
    var data = [];
    for (var value in map.values) {
      if (value['position'] == position) {
        data.add(value);
      }
    }
    yield data;
  }

  // Future<void> _fetchAppointments() async {
  static Stream getBilik() async* {
    final databaseReference = FirebaseDatabase.instance.ref();
    final userRef = databaseReference.child("monitoring");
    final snapshot = await userRef.get();
    final map = snapshot.value as Map<dynamic, dynamic>;
    var output = [];
    var key = List.from(map.keys);

    int i = 0;
    for (var value in map.values) {
      MonitoringModel monit = monitoringModelFromJson(json.encode(value));
      output.add({
        'key': key[i],
        'label': monit.bilik,
      });
      i++;
    }
    output = List.from(output.reversed);

    // output.map((out) => out['key'].cast<String>());
    // debugPrint("CHECK : ${element['key']}");

    for (var num = 0; i < output.length; num++) {
      output[num]['key'] = output[num]['key'].cast<String>();
      output[num]['label'] = output[num]['label'].cast<String>();
    }

    debugPrint("OUTPUT : $output");
    yield output;
  }

  static Stream getBilikbyKey({required String key}) async* {
    final databaseReference = FirebaseDatabase.instance.ref();
    final userRef = databaseReference.child("monitoring").child(key);
    final snapshot = await userRef.get();

    final map = snapshot.value as Map<dynamic, dynamic>;
    yield map;
  }

  static Stream getBilikbyKey2({required String key}) async* {
    final databaseReference = FirebaseDatabase.instance.ref();
    dynamic dbref = databaseReference.child("monitoring").child(key).onValue;

    yield dbref;
  }

  static Stream getUsersName({required String position}) async* {
    final databaseReference = FirebaseDatabase.instance.ref();
    final userRef = databaseReference.child("users");
    final snapshot = await userRef.get();
    // print('dataSnapshot :');
    // print(snapshot);

    final map = snapshot.value as Map<dynamic, dynamic>;
    var data = [];
    for (var value in map.values) {
      if (value['position'] == position) {
        data.add(value);
      }
    }
    yield data;
  }
}
