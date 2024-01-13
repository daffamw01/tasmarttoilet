import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasmarttoilet/controller/bluetooth_controller.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';
import 'package:tasmarttoilet/view/Account_Page.dart';

class BlueScanPage extends StatefulWidget {
  const BlueScanPage({super.key});
  static void showBlueScanDialog(BuildContext context) {
    showAnimatedDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const BlueScanPage();
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  State<BlueScanPage> createState() => _BlueScanPageState();
}

class _BlueScanPageState extends State<BlueScanPage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: GetBuilder<BluetoothController>(
          init: BluetoothController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(children: [
                judulDialog(context, 'Presensi Bluetooth'),
                ElevatedButton(
                    onPressed: () => controller.scanDevices(),
                    child: const Text("Presensi")),
                StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  initialData: const [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data!.map((r) {
                      // print();
                      String isi = r.device.id.toString();
                      print(isi);
                      if (isi == "B8:27:EB:C4:60:BD") {
                        DateTime datenow = DateTime.now();
                        String formattedDate =
                            DateFormat('EEEE, dd/MM/yyyy').format(datenow);
                        DateTime dateTime =
                            DateFormat('EEEE, dd/MM/yyyy').parse(formattedDate);
                        print(dateTime);
                        // Object huhuh = 'Sudah Absen';

                        final firestoreIns = FirebaseFirestore.instance;

                        firestoreIns
                            .collection('schedule')
                            .where('date', isEqualTo: dateTime)
                            .where('fullName',
                                isEqualTo: GlobalVariables.globalVariable)
                            .get()
                            .then((QuerySnapshot querysnapshot) {
                          if (querysnapshot.docs.isNotEmpty) {
                            String documentId = querysnapshot.docs.first.id;

                            firestoreIns
                                .collection('schedule')
                                .doc(documentId)
                                .update({'presensi': 'Sudah Presensi'}).then(
                                    (_) {
                              Fluttertoast.showToast(
                                  msg: 'Anda Sudah Presensi');
                            });
                          }
                          // else {
                          //   firestoreIns
                          //       .collection('schedule')
                          //       .add({'presensi': 'Sudah Presensi'}).then(
                          //           (DocumentReference docRef) {
                          //     Fluttertoast.showToast(
                          //         msg: 'Anda Berhasil Presensi');
                          //   });
                          // }
                        });
                        Fluttertoast.showToast(msg: "Berhasil Presensi");
                      }
                      // else {
                      //   Fluttertoast.showToast(msg: "Gagal Absen");
                      // }
                      return Container();
                    }).toList(),
                    // ScanResultTile(
                    //   result: r,
                    //   onTap: () =>  Navigator.of(context)
                    //       .push(MaterialPageRoute(builder: (context) {
                    //     r.device.connect();
                    //     return DeviceScreen(device: r.device);
                    //   })),
                    // ),
                  ),
                )
              ]),
            );
          }),
    );
  }
}
