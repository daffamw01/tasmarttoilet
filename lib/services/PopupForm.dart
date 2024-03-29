import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart'
    as CustomDialog;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ndialog/ndialog.dart';

class SignUpDialog extends StatefulWidget {
  const SignUpDialog({super.key});

  static void showSignUpDialog(BuildContext context) {
    CustomDialog.showAnimatedDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const SignUpDialog();
      },
      animationType: DialogTransitionType.BottomToTop,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  _SignUpDialogState createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  String? selectedPosition;
  var phoneNumberController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              decoration: const BoxDecoration(
                  color: Color(0XFF00799F),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontFamily: 'SansPro',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: const Color(0XFFFFFFFF),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: _imageFile != null
                                      ? FileImage(_imageFile!) as ImageProvider
                                      : const AssetImage('images/account.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _pickImage();
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: fullNameController,
                    decoration:
                        const InputDecoration(labelText: 'Nama Lengkap'),
                  ),
                  ListTile(
                    title: const Text('Posisi'),
                    contentPadding: const EdgeInsets.all(0),
                    trailing: DropdownButton<String>(
                      value: selectedPosition,
                      onChanged: (value) {
                        setState(() {
                          selectedPosition = value;
                        });
                      },
                      items: ['Admin', 'Petugas'].map((String position) {
                        return DropdownMenuItem<String>(
                          value: position,
                          child: Text(position),
                        );
                      }).toList(),
                    ),
                  ),
                  TextFormField(
                    controller: phoneNumberController,
                    decoration: const InputDecoration(labelText: 'Nomor HP'),
                  ),
                ],
              ),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: const Text('Batal'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Simpan'),
                  onPressed: () async {
                    var email = emailController.text.trim();
                    var password = passwordController.text.trim();
                    var fullName = fullNameController.text.trim();
                    final String? position = selectedPosition;
                    var phoneNumber = phoneNumberController.text.trim();

                    if (email.isEmpty ||
                        password.isEmpty ||
                        fullName.isEmpty ||
                        (position == null || position.isEmpty) ||
                        phoneNumber.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Isi semua form dengan lengkap');
                      return;
                    }

                    if (password.length < 6) {
                      Fluttertoast.showToast(
                          msg: 'Isi password minimal 6 karakter');
                      return;
                    }

                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()));
                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;

                      UserCredential userCredential =
                          await auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      if (userCredential.user != null) {
                        DatabaseReference userRef =
                            FirebaseDatabase.instance.ref().child('users');

                        String uid = userCredential.user!.uid;

                        var filename = '$email.jpg';
                        UploadTask uploadTask = FirebaseStorage.instance
                            .ref()
                            .child('profile_images')
                            .child(filename)
                            .putFile(_imageFile!);
                        TaskSnapshot snapshot = await uploadTask;
                        String profileImageUrl =
                            await snapshot.ref.getDownloadURL();

                        await userRef.child(uid).set({
                          'profileImage': profileImageUrl,
                          'fullName': fullName,
                          'email': email,
                          'position': position,
                          'phoneNumber': phoneNumber,
                          'uid': uid,
                        });
                        Fluttertoast.showToast(msg: 'Success');
                        Navigator.of(context).pop();
                      } else {
                        Fluttertoast.showToast(msg: 'Failed');
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'invalid-email') {
                        Fluttertoast.showToast(msg: 'Email Format Wrong');
                      } else if (e.code == 'email-already-exists') {
                        Fluttertoast.showToast(msg: 'Email is already in use');
                      } else if (e.code == 'weak-password') {
                        Fluttertoast.showToast(msg: 'Password is weak');
                      }
                    } catch (e) {
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(msg: 'Something went wrong');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
