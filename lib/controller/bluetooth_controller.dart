// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  // final Stream<bool> _flutterBluePlus = FlutterBluePlus.isScanning;
  // FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  Future scanDevices() async {
    // FlutterBluePlus.isScanning;
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    // Listen to scan results

    // Stop scanning
    flutterBlue.stopScan();
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;
}
