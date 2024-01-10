import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasmarttoilet/view/BlueScan_Page.dart';
import 'package:tasmarttoilet/services/ChangePass.dart';
import 'package:tasmarttoilet/models/User_Model.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';
import 'package:tasmarttoilet/services/getData.dart';

// file_variabel_global.dart
class GlobalVariables {
  static String globalVariable = "";
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool click = false;

  void _toggleMode() {
    setState(() {
      click = !click;
    });
  }

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
                child: StreamBuilder(
                    stream: GetData.getUsersPetugas(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        UserModel pegawai =
                            userModelFromJson(json.encode(snapshot.data));
                        GlobalVariables.globalVariable = pegawai.fullName;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, bottom: 20),
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hai, Selamat Datang",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'SansPro',
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.065,
                                    ),
                                  ),
                                  Text(
                                    "${pegawai.fullName}!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'SansPro',
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.065,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: click ? 355 : 300,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: PageView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, position) {
                                            return SingleChildScrollView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 100,
                                                    backgroundImage:
                                                        NetworkImage(pegawai
                                                            .profileImage),
                                                  ),
                                                  Text(
                                                    pegawai.fullName,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.075,
                                                        fontFamily: 'SansPro',
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    pegawai.position,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                        fontFamily: 'SansPro',
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    pegawai.email,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                        fontFamily: 'SansPro',
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    pegawai.phoneNumber,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                        fontFamily: 'SansPro',
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                    InkWell(
                                        onTap: _toggleMode,
                                        child: click
                                            ? const Icon(
                                                Icons.keyboard_arrow_up,
                                                size: 30)
                                            : const Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 30))
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      BlueScanPage.showBlueScanDialog(context);
                                    },
                                    child: accountbox(
                                        context,
                                        'Presensi',
                                        const Color(0XFF00FF8F),
                                        const Color(0XFF00AFFF),
                                        const Icon(Icons.bluetooth_outlined,
                                            size: 30)),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      ChangePasswordPage.showChangePassDialog(
                                          context);
                                    },
                                    child: accountbox(
                                        context,
                                        'Ganti Password',
                                        const Color(0XFFFFD500),
                                        const Color(0XFFFF95FC),
                                        const Icon(Icons.lock_reset, size: 30)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17))),
                                  icon: const Icon(Icons.logout_outlined,
                                      size: 32),
                                  label: const Text(
                                    'Sign Out',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: const Text(
                                                  'Konfirmasi logout'),
                                              content: const Text(
                                                  'Apakah anda yakin ingin keluar?'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Tidak'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Ya'),
                                                  onPressed: () async {
                                                    await FirebaseAuth.instance
                                                        .signOut();
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            ));
                                  }),
                            )
                          ],
                        );
                      }
                      return Container();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
