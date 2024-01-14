import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tasmarttoilet/models/schedule_model.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';
import 'package:tasmarttoilet/services/getData.dart';

class EditJadwal extends StatefulWidget {
  const EditJadwal({super.key});

  static void showEditScheduleDialog(BuildContext context) {
    showAnimatedDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const EditJadwal();
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  _EditJadwalState createState() => _EditJadwalState();
}

class _EditJadwalState extends State<EditJadwal> {
  TextEditingController dateController = TextEditingController();
  String? selectedFullName;
  String? selectedPosition;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    String formattedDate = DateFormat('EEEE, dd/MM/yyyy').format(_selectedDate);
    dateController.text = formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            judulDialog(context, 'Edit Jadwal'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                          labelText: 'Pilih Tanggal',
                          suffixIcon: IconButton(
                              onPressed: () => _selectDate(context),
                              icon: const Icon(Icons.calendar_month))),
                      readOnly: true,
                    ),
                    StreamBuilder(
                        stream: GetData.getUsers(position: 'Petugas'),
                        builder: (context, snapshot) {
                          List<DropdownMenuItem<String>> items = [];
                          if (snapshot.hasData) {
                            final List<dynamic> data = snapshot.data;
                            for (var item in data) {
                              items.add(DropdownMenuItem<String>(
                                  value: item['fullName'],
                                  child: Text(item['fullName'])));
                            }
                          }
                          return ListTile(
                            title: const Text('Petugas'),
                            contentPadding: const EdgeInsets.all(0),
                            trailing: DropdownButton<String>(
                              value: selectedFullName,
                              onChanged: (value) {
                                setState(() {
                                  selectedFullName = value;
                                });
                              },
                              items: items,
                            ),
                          );
                        }),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: const Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Simpan'),
                  onPressed: () {
                    saveDataToFirebase();
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        String formattedDate = DateFormat('EEEE, dd/MM/yyyy').format(picked);
        dateController.text = formattedDate;
      });
    }
  }

  void saveDataToFirebase() async {
    String selectedDate = dateController.text;
    DateTime dateTime = DateFormat('EEEE, dd/MM/yyyy').parse(selectedDate);
    String fullName = selectedFullName ?? "";
    String presensi = "Belum Presensi";

    if (fullName.isNotEmpty) {
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
      DatabaseEvent snapshot = await databaseReference
          .child('users')
          .orderByChild('fullName')
          .equalTo(fullName)
          .once();
      if (snapshot.snapshot.value != null) {
        final Map<dynamic, dynamic>? userData =
            snapshot.snapshot.value as dynamic;
        print("userData: $userData");
        String uid = userData!.keys.first;

        ScheduleModel schedule = ScheduleModel(
            date: dateTime, fullName: fullName, uid: uid, presensi: presensi);

        final firestoreInstance = FirebaseFirestore.instance;

        firestoreInstance
            .collection('schedule')
            .where('date', isEqualTo: schedule.date)
            .get()
            .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            firestoreInstance
                .collection('schedule')
                .doc(querySnapshot.docs.first.id)
                .update(schedule.toFirestore())
                .then((_) {
              Fluttertoast.showToast(msg: 'Data Berhasil diperbarui');
            }).catchError((error) {
              Fluttertoast.showToast(
                  msg: 'Terjadi Kesalahan saat memperbarui data: $error');
            });
          } else {
            firestoreInstance
                .collection('schedule')
                .add(schedule.toFirestore())
                .then((DocumentReference docRef) {
              Fluttertoast.showToast(msg: 'Data berhasil ditambahkan');
            }).catchError((error) {
              Fluttertoast.showToast(
                  msg: 'Terjadi kesalahan saat menambahkan data baru: $error');
            });
          }
        });
      } else {
        Fluttertoast.showToast(msg: 'UID tidak ditemukan untuk $fullName');
      }
    } else {
      Fluttertoast.showToast(msg: 'Pilih Nama terlebih dahulu');
    }
  }
}
