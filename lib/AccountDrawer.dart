import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasmarttoilet/accountpage.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';
import 'package:tasmarttoilet/services/getData.dart';

class AccountDrawer extends StatefulWidget {
  const AccountDrawer({super.key});

  @override
  State<AccountDrawer> createState() => _AccountDrawerState();
}

class _AccountDrawerState extends State<AccountDrawer> {
  File? selectedImage;

  void handleImageSelected(File? image) {
    setState(() {
      selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Color(0xFF003452),
        padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage('images/fotodawe.jpg'),
            ),
            SizedBox(height: 12),
            StreamBuilder(
                stream: GetData.getUsersPetugas(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Column(
                      children: [
                        Text(
                          snapshot.data['fullName'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontFamily: 'SansPro',
                          ),
                        ),
                        Text(
                          snapshot.data['position'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'SansPro',
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
            // Text(
            //   'Daffa Maheswara',
            //   style: TextStyle(fontSize: 28, color: Colors.white),
            // ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 12,
          children: [
            // ListTile(
            //   leading: Icon(Icons.account_circle_outlined),
            //   title: Text('Profile Detail'),
            //   onTap: () {
            //     showDialog(
            //         context: context,
            //         builder: (context) => Dialog(
            //               shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(20)),
            //               child: SingleChildScrollView(
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       alignment: Alignment.center,
            //                       width: double.infinity,
            //                       height: 50,
            //                       decoration: BoxDecoration(
            //                           color: Color(0XFF00799F),
            //                           borderRadius: BorderRadius.only(
            //                               topLeft: Radius.circular(20),
            //                               topRight: Radius.circular(20))),
            //                       child: Text(
            //                         'Profile Detail',
            //                         style: TextStyle(
            //                             color: Colors.white,
            //                             fontSize:
            //                                 MediaQuery.of(context).size.width *
            //                                     0.06,
            //                             fontFamily: 'SansPro',
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: EdgeInsets.all(15),
            //                       child: Column(
            //                         children: <Widget>[
            //                           pickphoto(
            //                               onImageSelected: handleImageSelected,
            //                               initialImage:
            //                                   AssetImage('images/account.png')),
            //                           SizedBox(height: 10),
            //                           SizedBox(
            //                               width:
            //                                   MediaQuery.of(context).size.width,
            //                               child: Text(
            //                                 'Nama   : Daffa Maheswara',
            //                                 style: TextStyle(
            //                                     fontSize: 18,
            //                                     fontFamily: 'SansPro',
            //                                     fontWeight: FontWeight.bold),
            //                                 // textAlign: TextAlign.center,
            //                               )),
            //                           SizedBox(height: 10),
            //                           SizedBox(
            //                               width:
            //                                   MediaQuery.of(context).size.width,
            //                               child: Text(
            //                                 'Posisi   : Petugas',
            //                                 style: TextStyle(
            //                                     fontSize: 18,
            //                                     fontFamily: 'SansPro',
            //                                     fontWeight: FontWeight.bold),
            //                                 // textAlign: TextAlign.center,
            //                               )),
            //                           SizedBox(height: 10),
            //                           SizedBox(
            //                               width:
            //                                   MediaQuery.of(context).size.width,
            //                               child: Text(
            //                                 'Email   : daffamw@gmail.com',
            //                                 style: TextStyle(
            //                                     fontSize: 18,
            //                                     fontFamily: 'SansPro',
            //                                     fontWeight: FontWeight.bold),
            //                                 // textAlign: TextAlign.center,
            //                               )),
            //                           SizedBox(height: 10),
            //                           SizedBox(
            //                               width:
            //                                   MediaQuery.of(context).size.width,
            //                               child: Text(
            //                                 'No. Hp : 081284066987',
            //                                 style: TextStyle(
            //                                     fontSize: 18,
            //                                     fontFamily: 'SansPro',
            //                                     fontWeight: FontWeight.bold),
            //                                 // textAlign: TextAlign.center,
            //                               )),
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ));
            //     // pickphoto(
            //     //     onImageSelected: handleImageSelected,
            //     //     initialImage: AssetImage('images/account.png'));
            //     // if (selectedImage != null) Image.file(selectedImage!);

            //     // Navigator.pop(context);
            //     // Navigator.of(context).push(
            //     //     MaterialPageRoute(builder: (context) => AccountPage()));
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.checklist_outlined),
              title: Text('Absen'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.password_outlined),
              title: Text('Ganti password'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Keluar akun'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Konfirmasi logout'),
                          content: Text('Apakah anda yakin ingin keluar?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Tidak'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Ya'),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ));
              },
            ),
          ],
        ),
      );
}
