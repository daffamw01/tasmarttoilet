// import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "dart:convert";

import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:tasmarttoilet/models/MonitoringModel.dart";
import "package:tasmarttoilet/models/user_model.dart";
import "package:tasmarttoilet/reusable_widget/reusable_widget.dart";
import "package:tasmarttoilet/services/getData.dart";
// import "package:tasmarttoilet/JadwalPegawai.dart";

// void main() {
//   runApp(const MonitoringPegawai());
// }

class MonitoringPegawai extends StatefulWidget {
  const MonitoringPegawai({super.key});

  @override
  State<MonitoringPegawai> createState() => _MonitoringPegawaiState();
}

class _MonitoringPegawaiState extends State<MonitoringPegawai> {
  // int _currentIndex = 0;
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedValue = 'bilik1';
  TextEditingController customOptionController = TextEditingController();
  // int index = 0; //SALAH
  final fb = FirebaseDatabase.instance;
  dynamic monit2;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   setState(() {});
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final DatabaseReference monitRef = fb.ref().child("monitoring");
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    // theme: ThemeData(
    //     pageTransitionsTheme: PageTransitionsTheme(builders: {
    //   TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    // })),
    // home:
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          // child: Stack(
          children: [
            const Background(),
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 10,
                      right: 10), //pake appbar 10 kalo gapake 50
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: GetData.getBilik(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data != null) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        // border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0XFFffffff)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        value: snapshot.data[0]['key'],
                                        dropdownColor: const Color(0XFFffffff),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedValue = newValue!;
                                          });
                                        },
                                        items: snapshot.data
                                            .map<DropdownMenuItem<String>>(
                                          (dynamic value) {
                                            return DropdownMenuItem<String>(
                                              value: value['key'],
                                              onTap: () {
                                                setState(() {
                                                  selectedValue = value['key'];
                                                });
                                              },
                                              child: Text(
                                                value['label'],
                                                style: const TextStyle(
                                                    fontFamily: 'SansPro',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      StreamBuilder(
                          stream: monitRef.child(selectedValue).onValue,
                          // GetData.getBilikbyKey2(key: selectedValue),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData &&
                                !snapshot.hasError &&
                                snapshot.data!.snapshot.value != null) {
                              monit2 = MonitoringModel.fromJson(
                                  snapshot.data.snapshot.value);
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Container(
                                      // Status Kebersihan
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.505,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          //================================================   STATUS KENYAMANAN   ===============================================================================
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 15, right: 15),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF003452),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'Status Kenyamanan',
                                                style: TextStyle(
                                                  fontFamily: 'SansPro',
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          //===============================================================    PERSENTASE KEBERSIHAN   ==================================================================
                                          Padding(
                                            padding: const EdgeInsets.all(15
                                                // top: 15, left: 50, right: 50
                                                ),
                                            child: Container(
                                              //LINGKARAN LUAR
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.65,
                                              decoration: const BoxDecoration(
                                                color: Color(0XFF084B72),
                                                shape: BoxShape.circle,
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color(0XFF084B72),
                                                    Color(0XFF1471B7),
                                                  ],
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Container(
                                                //LINGKARAN DALAM
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.55,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.55,
                                                decoration: const BoxDecoration(
                                                  color: Color(0XFF0D232C),
                                                  shape: BoxShape.circle,
                                                ),
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  // PERSENTASE
                                                  '100%',
                                                  style: TextStyle(
                                                    fontFamily: 'SansPro',
                                                    fontSize: 60,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //==================================================================   KEJERNIHAN AIR    =================================================================================================================================
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                //BASE KOTAK KEJERNIHAN AIR
                                                padding: const EdgeInsets.only(
                                                  bottom: 15,
                                                  left: 15,
                                                ),
                                                child: monitoringbox1(
                                                    context,
                                                    'Kejernihan Air',
                                                    '${monit2.kejernihanAir}%'),
                                              ),
                                              const Spacer(),
                                              //====================================================================    VOLUME AIR     ==================================================================================================================
                                              Padding(
                                                //BASE KOTAK VOLUME AIR
                                                padding: const EdgeInsets.only(
                                                  // left: MediaQuery.of(context).size.width *
                                                  //     0.06,
                                                  bottom: 15,
                                                  right: 15,
                                                ),
                                                child: monitoringbox1(
                                                    context,
                                                    'Volume Air',
                                                    '${monit2.volumeAir}%'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    //Kenyamanan Toilet
                                    child: Column(
                                      children: [
                                        //================================================    JUDUL KONDISI UDARA    =============================================================================
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 35, 5, 10
                                                // top: 35,
                                                // bottom: 10,
                                                // left: 5,
                                                // right: 5,
                                                ),
                                            child: judulmonitoring(
                                                context, 'Kondisi Udara')),
                                        //================================================          KELEMBAPAN & SUHU RUANG           ===============================================================================
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                //SUHU AIR
                                                padding: const EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5,
                                                ),
                                                child: monitoringbox2(
                                                    context,
                                                    'Kelembapan',
                                                    '${monit2.kelembapan}%'),
                                              ),
                                              const Spacer(),
                                              Padding(
                                                //SUHU RUANG
                                                padding: const EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5,
                                                ),
                                                child: monitoringbox2(
                                                    context,
                                                    'Suhu Ruang',
                                                    '${monit2.suhuRuang}°C'),
                                              )
                                            ],
                                          ),
                                        ),
                                        //================================================          TINGKAT BAU         =====================================================================
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              // Padding(
                                              //   //KELEMBAPAN
                                              //   padding: const EdgeInsets.only(
                                              //     bottom: 0,
                                              //     left: 5,
                                              //     right: 5,
                                              //   ),
                                              //   child: monitoringbox2(
                                              //       context,
                                              //       'Kelembapan',
                                              //       '${monit2.kelembapan}%'),
                                              // ),
                                              // const Spacer(),
                                              Padding(
                                                //TINGKAT BAU
                                                padding: const EdgeInsets.only(
                                                  bottom: 0,
                                                  left: 5,
                                                  right: 5,
                                                ),
                                                child: monitoringbox2(
                                                    context,
                                                    'Tingkat Bau',
                                                    '${monit2.tingkatBau}%'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    //Ketersediaan Fasilitas
                                    child: Column(
                                      children: [
                                        //===============================================================   JUDUL KETERSEDIAAN FASILITAS    =================================================================
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 30, 5, 10),
                                            // top: 30, bottom: 10, left: 5, right: 5),
                                            child: judulmonitoring(context,
                                                'Ketersediaan Fasilitas')),
                                        //=========================================================        PERSENTASE SABUN & TISSUE TOILET       =================================================================
                                        SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                  //SABUN
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 10,
                                                    left: 5,
                                                    right: 5,
                                                  ),
                                                  child: monitoringbox2(
                                                      context,
                                                      'Sabun',
                                                      '${monit2.sabun}%')),
                                              const Spacer(),
                                              Padding(
                                                  //TISSUE TOILET
                                                  padding:
                                                      const EdgeInsets.only(
                                                    bottom: 10,
                                                    left: 5,
                                                    right: 5,
                                                  ),
                                                  child: monitoringbox2(
                                                      context,
                                                      'Tissue Toilet',
                                                      '${monit2.tissue}%')),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const CircularProgressIndicator();
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // );
  }
}
