import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_blue/flutter_blue.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:tasmarttoilet/BluetoothTry.dart';
import 'package:tasmarttoilet/BluetoothWidget.dart';
import 'package:tasmarttoilet/controller/bluetooth_controller.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';

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
                judulDialog(context, 'Bluetooth Scanning'),
                ElevatedButton(
                    onPressed: () => controller.scanDevices(),
                    child: const Text("Scan")),
                StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  initialData: const [],
                  builder: (c, snapshot) => Column(
                    children: snapshot.data!
                        .map(
                          (r) => ScanResultTile(
                            result: r,
                            onTap: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              r.device.connect();
                              return DeviceScreen(device: r.device);
                            })),
                          ),
                        )
                        .toList(),
                  ),
                )
                // if (snapshot.hasData) {
                //   return ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: snapshot.data!.length,
                //       itemBuilder: (context, index) {
                //         final data = snapshot.data![index];
                //         return ListTile(
                //           title: Text(data.device.name),
                //           subtitle: Text(data.device.id.id),
                //           trailing: Text(data.rssi.toString()),
                //         );
                //       });
                // } else {
                //   return const Center(
                //     child: Text("No Devices Found"),
                //   );
                // }
              ]),
            );
          }),
    );
  }
}
