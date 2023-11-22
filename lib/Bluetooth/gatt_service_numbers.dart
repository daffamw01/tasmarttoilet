library gatt_service_numbers;

//import 'dart:collection';

/// Provides service number information
class GattServiceNumbers {
  static const Map<String, String> valueToName = {
    "1800": 'Generic Access',
    "1801": 'Generic Attribute',
    "180A": 'Device Information',
    "180D": 'Heart Rate',
    "180F": 'Battery Service',
    "181E": 'Bond Management Service',
  };

  const GattServiceNumbers();

  /// Returns string associated wiht serviceNumber
  String? getName(String serviceNumber) {
    return valueToName[serviceNumber];
  }
}
