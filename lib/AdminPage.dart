import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tasmarttoilet/EditJadwal.dart';
import 'package:tasmarttoilet/PopupForm.dart';
import 'package:tasmarttoilet/gantipass.dart';
import 'package:tasmarttoilet/models/user_model.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';
import 'package:tasmarttoilet/services/getData.dart';

// class ListPegawai {
//   final String name;
//   final String role;
//   final String imagePath;
//   final Color backgroundColor;

//   ListPegawai({
//     required this.name,
//     required this.role,
//     required this.imagePath,
//     required this.backgroundColor,
//   });
// }

// void main(List<String> args) {
//   runApp(const AdminPage());
// }

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  // bool _isFormOpen = false;

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
                            // decoration: const BoxDecoration(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(10))),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.task),
                              label: const Text(
                                'Edit Jadwal',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              // style: ElevatedButton.styleFrom(
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                // final editJadwalController =
                                //     TextEditingController();
                                // final editWaktuController =
                                //     TextEditingController();
                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return Dialog(
                                //         shape: RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(20)),
                                //         child: SingleChildScrollView(
                                //           child: Column(
                                //             children: [
                                //               judulDialog(
                                //                   context, 'Edit Jadwal'),
                                //               Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(16.0),
                                //                 child: Form(
                                //                   // key: _formKey,
                                //                   child: Column(
                                //                     children: <Widget>[
                                //                       TextFormField(
                                //                         controller:
                                //                             editJadwalController,
                                //                         obscureText: true,
                                //                         decoration:
                                //                             const InputDecoration(
                                //                                 labelText:
                                //                                     'Kata Sandi Lama'),
                                //                         // validator: (value) {
                                //                         //   if (value!.isEmpty) {
                                //                         //     Fluttertoast.showToast(
                                //                         //         msg: 'Kata Sandi Lama harus diisi');
                                //                         //     return;
                                //                         //   }
                                //                         //   return null;
                                //                         // },
                                //                       ),
                                //                       TextFormField(
                                //                         controller:
                                //                             editWaktuController,
                                //                         obscureText: true,
                                //                         decoration:
                                //                             const InputDecoration(
                                //                                 labelText:
                                //                                     'Kata Sandi Baru'),
                                //                         // validator: (value) {
                                //                         //   return null;
                                //                         // },
                                //                       ),
                                //                       const SizedBox(
                                //                           height: 16),
                                //                       // ElevatedButton(
                                //                       //   onPressed: _changePassword,
                                //                       //   child: const Text('Ganti Password'),
                                //                       // ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ),
                                //               ButtonBar(
                                //                 children: <Widget>[
                                //                   TextButton(
                                //                     child: const Text('Batal'),
                                //                     onPressed: () {
                                //                       Navigator.of(context)
                                //                           .pop();
                                //                     },
                                //                   ),
                                //                   TextButton(
                                //                     child: const Text('Simpan'),
                                //                     onPressed: () {
                                //                       // String oldPassword = _oldPasswordController.text;
                                //                       // String newPassword = _newPasswordController.text;
                                //                       // if (oldPassword.isEmpty) {
                                //                       //   Fluttertoast.showToast(
                                //                       //       msg: 'Kata Sandi Lama harus diisi');
                                //                       //   return;
                                //                       // }
                                //                       // if (newPassword.isEmpty) {
                                //                       //   Fluttertoast.showToast(
                                //                       //       msg: 'Kata Sandi Baru harus diisi');
                                //                       //   return;
                                //                       // }
                                //                       Container();
                                //                     },
                                //                   )
                                //                 ],
                                //               )
                                //             ],
                                //           ),
                                //         ),
                                //       );
                                //     });
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
                            //here's the typo;

                            // print('ini error');
                            // print();
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
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.start,
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
