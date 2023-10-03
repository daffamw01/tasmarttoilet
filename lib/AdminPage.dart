import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tasmarttoilet/PopupForm.dart';
import 'package:tasmarttoilet/accountpage.dart';
import 'package:tasmarttoilet/models/user_model.dart';
import 'package:tasmarttoilet/services/getData.dart';

class ListPegawai {
  final String name;
  final String role;
  final String imagePath;
  final Color backgroundColor;

  ListPegawai({
    required this.name,
    required this.role,
    required this.imagePath,
    required this.backgroundColor,
  });
}

void main(List<String> args) {
  runApp(AdminPage());
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Future getdata() async {
    return [];
  }

  // bool _isFormOpen = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Image.asset(
                'images/background.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 10,
                      right: 10), //pake appbar 10 kalo gapake 30
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 10, bottom: 20),
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          "Hai, Selamat Pagi Daffa!",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SansPro',
                            fontSize: MediaQuery.of(context).size.width * 0.065,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TotalPegawai(
                            position: 'Admin',
                          ),
                          Spacer(),
                          TotalPegawai(
                            position: 'Petugas',
                          ),
                        ],
                      ),
                      Petugas(
                        position: 'Admin',
                      ),
////////////////////////////////////////////////////////////////////////        PETUGAS       ///////////////////////////////////////////////
                      Petugas(
                        position: 'Petugas',
                      ),

                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: ElevatedButton(
                          child: Text(
                            'Buat Akun Baru',
                            style: TextStyle(
                                fontFamily: 'SansPro',
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                          onPressed: () {
                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return PopupForm();
                            //   },
                            // );
                            // SignUpDialog dialog = SignUpDialog(); // Buat instance dari SignUpDialog
                            // dialog.showSignUpDialog(context);
                            SignUpDialog.showSignUpDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            backgroundColor: Color(0xFF06141C),
                            minimumSize: Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.07),
                          ),
                        ),
                      ),

                      // Padding(
                      //   // width: MediaQuery.of(context).size.width,
                      //   // alignment: Alignment.bottomCenter,
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      //   child: AnimatedContainer(
                      //     duration: Duration(milliseconds: 500),
                      //     width: MediaQuery.of(context).size.width,
                      //     height: _isFormOpen ? 0 : 50,
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         // setState(() {
                      //         //   _isFormOpen = true;}
                      //         // );
                      //       },
                      //       child: Text(
                      //         'Buat Akun Baru',
                      //         style: TextStyle(
                      //             fontFamily: 'SansPro', fontSize: 16),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // // Tampilkan Popup Form ketika _isFormOpen true
                      // if (_isFormOpen)
                      //   Align(
                      //     alignment: Alignment.bottomCenter,
                      //     child: AnimatedContainer(
                      //       duration: Duration(milliseconds: 500),
                      //       height: _isFormOpen ? 300 : 0,
                      //       child: PopupForm(),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TotalPegawai extends StatelessWidget {
  const TotalPegawai({super.key, required this.position});
  final String position;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.425,
        height: MediaQuery.of(context).size.height * 0.035,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        child: StreamBuilder(
            stream: GetData.getUsers(position: position),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Text(
                  "Petugas : ${snapshot.data.length}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontFamily: 'SansPro',
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
              return Container();
            }),
      ),
    );
  }
}

class Petugas extends StatelessWidget {
  const Petugas({
    super.key,
    required this.position,
  });

  final String position;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.307,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, top: 15, bottom: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    color: Color(0XFF00799F),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    position,
                    style: TextStyle(
                      fontFamily: 'SansPro',
                      fontSize: MediaQuery.of(context).size.width * 0.065,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    child: StreamBuilder(
                        stream: GetData.getUsers(position: position),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            //here's the typo;

                            print('ini error');
                            // print();
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                Map<dynamic, dynamic> values = json
                                    .decode(json.encode(snapshot.data[index]));
                                final pegawai = UserModel.fromJson(
                                    values as Map<String, dynamic>);
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: 15.0,
                                    bottom: 5,
                                    top: 5,
                                    left: 5,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0XFF00799F),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20))),
                                                    child: Text(
                                                      "Informasi Pegawai",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24,
                                                          fontFamily: 'SansPro',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(15, 15, 0, 0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Nama  : ${pegawai.fullName}",
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'SansPro'),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "Posisi   : ${pegawai.position}",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'SansPro'),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 15.0),
                                                          child: Text(
                                                            "Email   : ${pegawai.email}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'SansPro'),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "No. Hp : ${pegawai.phoneNumber}",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'SansPro'),
                                                        ),
                                                        ButtonBar(
                                                          children: [
                                                            TextButton(
                                                              child:
                                                                  Text("Tutup"),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 160,
                                      decoration: BoxDecoration(
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(1, 2),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 10,
                                            ),
                                            child: CircleAvatar(
                                                // backgroundImage:
                                                // AssetImage(pegawai.imagePath),
                                                // radius: 27,
                                                ),
                                          ),
                                          Positioned(
                                            bottom: 30.0,
                                            left: 10,
                                            child: SizedBox(
                                              width: 150,
                                              child: Text(
                                                pegawai.fullName,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04,
                                                  fontFamily: 'SansPro',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 10.0,
                                            bottom: 10,
                                            child: Text(
                                              pegawai.position,
                                              style: TextStyle(
                                                fontFamily: 'SansPro',
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.035,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return Container();
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
