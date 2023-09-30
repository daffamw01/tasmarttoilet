import 'package:flutter/material.dart';
import 'package:tasmarttoilet/PopupForm.dart';
import 'package:tasmarttoilet/accountpage.dart';

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
  final List<ListPegawai> data = [
    ListPegawai(
      name: 'Daffa Maheswara',
      role: 'Admin',
      imagePath: 'images/fotodawe.jpg',
      backgroundColor: Color(0XFFEEFFB0),
    ),
    ListPegawai(
      name: 'Nasywaan Ammar S',
      role: 'Admin',
      imagePath: 'images/fotobaad.jpg',
      backgroundColor: Color(0XFFF4E0FB),
    ),
    ListPegawai(
      name: 'Nanda Fitri Tsalatsa',
      role: 'Admin',
      imagePath: 'images/fotoafit.jpg',
      backgroundColor: Color(0XFFDEB764),
    ),
  ];

  final List<ListPegawai> dataPetugas = [
    ListPegawai(
      name: 'Daffa Maheswara',
      role: 'Petugas',
      imagePath: 'images/fotodawe.jpg',
      backgroundColor: Color(0XFFB4573D),
    ),
    ListPegawai(
      name: 'Nasywaan Ammar S',
      role: 'Petugas',
      imagePath: 'images/fotobaad.jpg',
      backgroundColor: Color(0XFFFFDC830),
    ),
    ListPegawai(
      name: 'Nanda Fitri Tsalatsa',
      role: 'Petugas',
      imagePath: 'images/fotoafit.jpg',
      backgroundColor: Color(0XFF91C2BA),
    ),
    ListPegawai(
      name: 'Briyantama Wahab',
      role: 'Petugas',
      imagePath: 'images/fotokuli.jpg',
      backgroundColor: Color(0XFFB7AE9F),
    ),
  ];

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
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.425,
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Admin : ${data.length}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontFamily: 'SansPro',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.425,
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Petugas : ${dataPetugas.length}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontFamily: 'SansPro',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                      color: Color(0XFF00799F),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Admin',
                                      style: TextStyle(
                                        fontFamily: 'SansPro',
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.065,
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
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: data.length,
                                        itemBuilder: (context, index) {
                                          final pegawai = data[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              right: 15.0,
                                              bottom: 5,
                                              top: 5,
                                              left: 5,
                                            ),
                                            child: Container(
                                              width: 160,
                                              decoration: BoxDecoration(
                                                color: pegawai.backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: Offset(1, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10,
                                                    ),
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          AssetImage(pegawai
                                                              .imagePath),
                                                      radius: 27,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 30.0,
                                                    left: 10,
                                                    child: SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        pegawai.name,
                                                        maxLines: 1,
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                          fontFamily: 'SansPro',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 10,
                                                    left: 10.0,
                                                    child: Text(
                                                      pegawai.role,
                                                      style: TextStyle(
                                                        fontFamily: 'SansPro',
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
////////////////////////////////////////////////////////////////////////        PETUGAS       ///////////////////////////////////////////////
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
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
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                      color: Color(0XFF00799F),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Petugas',
                                      style: TextStyle(
                                        fontFamily: 'SansPro',
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.065,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Informasi Pegawai"),
                                            content: Text(
                                                "Tampilkan informasi lebih lanjut di sini."),
                                            actions: [
                                              TextButton(
                                                child: Text("Tutup"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: double.infinity,
                                        height: 160,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: dataPetugas.length,
                                          itemBuilder: (context, index) {
                                            final pegawai = dataPetugas[index];
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                right: 15.0,
                                                bottom: 5,
                                                top: 5,
                                                left: 5,
                                              ),
                                              child: Container(
                                                width: 160,
                                                decoration: BoxDecoration(
                                                  color:
                                                      pegawai.backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 10,
                                                      ),
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            AssetImage(pegawai
                                                                .imagePath),
                                                        radius: 27,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 30.0,
                                                      left: 10,
                                                      child: SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          pegawai.name,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.04,
                                                            fontFamily:
                                                                'SansPro',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 10.0,
                                                      bottom: 10,
                                                      child: Text(
                                                        pegawai.role,
                                                        style: TextStyle(
                                                          fontFamily: 'SansPro',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.035,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
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
