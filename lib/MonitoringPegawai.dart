// import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "dart:convert";

import "package:flutter/material.dart";
import "package:tasmarttoilet/models/MonitoringModel.dart";
import "package:tasmarttoilet/models/user_model.dart";
import "package:tasmarttoilet/reusable_widget/reusable_widget.dart";
import "package:tasmarttoilet/services/getData.dart";
// import "package:tasmarttoilet/JadwalPegawai.dart";

void main() {
  runApp(const MonitoringPegawai());
}

class MonitoringPegawai extends StatefulWidget {
  const MonitoringPegawai({super.key});

  @override
  State<MonitoringPegawai> createState() => _MonitoringPegawaiState();
}

class _MonitoringPegawaiState extends State<MonitoringPegawai> {
  // int _currentIndex = 0;
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedValue = 'Bilik 1';
  TextEditingController customOptionController = TextEditingController();
  int index = 0; //SALAH

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //     pageTransitionsTheme: PageTransitionsTheme(builders: {
      //   TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      // })),
      home: Scaffold(
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
                    child: StreamBuilder(
                        stream: GetData.getBilik(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            MonitoringModel monit = monitoringModelFromJson(
                                json.encode(snapshot.data[index]));
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
                                        value: monit.bilik,
                                        dropdownColor: const Color(0XFFffffff),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          monit.bilik
                                          // 'Bilik 3',
                                          // 'Bilik 4',
                                          // 'Tambah Bilik Baru',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                  fontFamily: 'SansPro',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                if (selectedValue == 'Tambah Bilik Baru')
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 7),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              // border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color(0XFFffffff)),
                                          child: TextFormField(
                                            controller: customOptionController,
                                            decoration: const InputDecoration(
                                                hintText: 'Tambah bilik baru',
                                                hintStyle: TextStyle(
                                                    color: Colors.black)),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            height: 50,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors
                                                    .blue, // Ubah warna latar belakang sesuai keinginan
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0), // Ubah bentuk sudut sesuai keinginan
                                                ),
                                                elevation:
                                                    3, // Ubah tinggi elevasi (shadow)
                                                textStyle: const TextStyle(
                                                    fontSize:
                                                        18), // Ubah gaya teks
                                              ),
                                              onPressed: () {
                                                if (selectedValue ==
                                                    'Tambah Bilik Baru') {
                                                  String newOption =
                                                      customOptionController
                                                          .text;
                                                  if (newOption.isNotEmpty) {
                                                    setState(() {
                                                      selectedValue = newOption;
                                                    });
                                                    customOptionController
                                                        .clear();
                                                  }
                                                }
                                              },
                                              child: const Text(
                                                'Simpan',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(
                                    // Status Kebersihan
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.505,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        //================================================   STATUS KEBERSIHAN   ===============================================================================
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
                                              'Status Kebersihan',
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
                                                  monit.kejernihanAir),
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
                                                  monit.volumeAir),
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
                                      //================================================    JUDUL KENYAMANAN TOILET    =============================================================================
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 35, 5, 10
                                              // top: 35,
                                              // bottom: 10,
                                              // left: 5,
                                              // right: 5,
                                              ),
                                          child: judulmonitoring(
                                              context, 'Kenyamanan Toilet')),
                                      //================================================          SUHU AIR & SUHU RUANG           ===============================================================================
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
                                              child: monitoringbox2(context,
                                                  'Suhu Air', monit.suhuAir),
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
                                                  monit.suhuRuang),
                                            )
                                          ],
                                        ),
                                      ),
                                      //================================================          KELEMBAPAN & TINGKAT BAU         =====================================================================
                                      SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              //KELEMBAPAN
                                              padding: const EdgeInsets.only(
                                                bottom: 0,
                                                left: 5,
                                                right: 5,
                                              ),
                                              child: monitoringbox2(
                                                  context,
                                                  'Kelembapan',
                                                  monit.kelembapan),
                                            ),
                                            const Spacer(),
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
                                                  monit.tingkatBau),
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
                                                padding: const EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5,
                                                ),
                                                child: monitoringbox2(context,
                                                    'Sabun', monit.sabun)),
                                            const Spacer(),
                                            Padding(
                                                //TISSUE TOILET
                                                padding: const EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 5,
                                                  right: 5,
                                                ),
                                                child: monitoringbox2(
                                                    context,
                                                    'Tissue Toilet',
                                                    monit.tissue)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   child: Padding(
                                //     padding: EdgeInsets.symmetric(
                                //         vertical: 10, horizontal: 5),
                                //     child: ElevatedButton.icon(
                                //       style: ElevatedButton.styleFrom(
                                //           minimumSize: Size.fromHeight(45),
                                //           shape: RoundedRectangleBorder(
                                //               borderRadius: BorderRadius.circular(10))),
                                //       icon: Icon(Icons.arrow_back, size: 32),
                                //       label: Text(
                                //         'Sign Out',
                                //         style: TextStyle(fontSize: 20),
                                //       ),
                                //       onPressed: () {
                                //         showDialog(
                                //             context: context,
                                //             builder: (context) => AlertDialog(
                                //                   title: Text('Konfirmasi logout'),
                                //                   content: Text(
                                //                       'Apakah anda yakin ingin keluar?'),
                                //                   actions: <Widget>[
                                //                     TextButton(
                                //                       child: Text('Tidak'),
                                //                       onPressed: () {
                                //                         Navigator.of(context).pop();
                                //                       },
                                //                     ),
                                //                     TextButton(
                                //                       child: Text('Ya'),
                                //                       onPressed: () async {
                                //                         await FirebaseAuth.instance
                                //                             .signOut();
                                //                         Navigator.of(context).pop();
                                //                       },
                                //                     )
                                //                   ],
                                //                 ));
                                //       },
                                //       // onPressed: () => FirebaseAuth.instance.signOut(),
                                //     ),
                                //   ),
                                // )
                              ],
                            );
                          }
                          return Container();
                        }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
