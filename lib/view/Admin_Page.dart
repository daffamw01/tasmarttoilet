import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasmarttoilet/services/EditJadwal.dart';
import 'package:tasmarttoilet/services/PopupForm.dart';
import 'package:tasmarttoilet/models/User_Model.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';
import 'package:tasmarttoilet/services/getData.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              const Background(),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 10,
                      right: 10), //pake appbar 10 kalo gapake 30
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 20),
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              "Hai, Selamat Pagi Daffa!",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SansPro',
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.065,
                              ),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            width: 115,
                            height: 50,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.task),
                              label: const Text(
                                'Edit Jadwal',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              onPressed: () {
                                EditJadwal.showEditScheduleDialog(context);
                              },
                            ),
                          )
                        ],
                      ),
                      const Row(
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
                      const Petugas(
                        position: 'Admin',
                      ),
                      const Petugas(
                        position: 'Petugas',
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            SignUpDialog.showSignUpDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            backgroundColor: const Color(0xFF06141C),
                            minimumSize: Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.07),
                          ),
                          child: Text(
                            'Buat Akun Baru',
                            style: TextStyle(
                                fontFamily: 'SansPro',
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
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
                  "$position : ${snapshot.data.length}",
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                    color: const Color(0XFF00799F),
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
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 160,
                    child: StreamBuilder(
                        stream: GetData.getUsers(position: position),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                UserModel pegawai = userModelFromJson(
                                    json.encode(snapshot.data[index]));

                                return Padding(
                                  padding: const EdgeInsets.only(
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
                                                    decoration: const BoxDecoration(
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
                                                    child: const Text(
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
                                                        Center(
                                                          child: CircleAvatar(
                                                            radius: 75,
                                                            backgroundImage:
                                                                NetworkImage(pegawai
                                                                    .profileImage),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 15),
                                                        Text(
                                                          "Nama  : ${pegawai.fullName}",
                                                          maxLines: 1,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'SansPro'),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          "Posisi   : ${pegawai.position}",
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'SansPro'),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
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
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    'SansPro'),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          "No. Hp : ${pegawai.phoneNumber}",
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'SansPro'),
                                                        ),
                                                        ButtonBar(
                                                          children: [
                                                            TextButton(
                                                              child: const Text(
                                                                  "Tutup"),
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
                                        color: RandomPastelColor(),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: const Offset(1, 2),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 10,
                                            ),
                                            child: CircleAvatar(
                                              radius: 27,
                                              backgroundImage: NetworkImage(
                                                  pegawai.profileImage),
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
