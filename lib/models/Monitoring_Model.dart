import 'dart:convert';

MonitoringModel monitoringModelFromJson(String str) =>
    MonitoringModel.fromJson(json.decode(str));

String monitoringModelToJson(MonitoringModel data) =>
    json.encode(data.toJson());

class MonitoringModel {
  String bilik;
  String kejernihanAir;
  String kelembapan;
  String sabun;
  String statusKenyamanan;
  String suhuRuang;
  String tingkatBau;
  String tissue;
  String volumeAir;

  MonitoringModel({
    required this.bilik,
    required this.kejernihanAir,
    required this.kelembapan,
    required this.sabun,
    required this.statusKenyamanan,
    required this.suhuRuang,
    required this.tingkatBau,
    required this.tissue,
    required this.volumeAir,
  });

  factory MonitoringModel.fromJson(Map<dynamic, dynamic> json) {
    return MonitoringModel(
      bilik: json["bilik"],
      kejernihanAir: json["kejernihanAir"],
      kelembapan: json["kelembapan"],
      sabun: json["sabun"],
      statusKenyamanan: json["statusKenyamanan"],
      suhuRuang: json["suhuRuang"],
      tingkatBau: json["tingkatBau"],
      tissue: json["tissue"],
      volumeAir: json["volumeAir"],
    );
  }

  Map<String, dynamic> toJson() => {
        "bilik": bilik,
        "kejernihanAir": kejernihanAir,
        "kelembapan": kelembapan,
        "sabun": sabun,
        "statusKenyamanan": statusKenyamanan,
        "suhuRuang": suhuRuang,
        "tingkatBau": tingkatBau,
        "tissue": tissue,
        "volumeAir": volumeAir,
      };
}
