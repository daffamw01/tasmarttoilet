import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  static void showChangePassDialog(BuildContext context) {
    showAnimatedDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const ChangePasswordPage();
      },
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // static void showChangePassDialog(BuildContext context) {
  //   showAnimatedDialog<void>(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return const ChangePasswordPage();
  //       });
  // }

  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;
      String oldPassword = _oldPasswordController.text;
      String newPassword = _newPasswordController.text;

      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: '${user!.email}',
          password: oldPassword,
        );

        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kata sandi berhasil diubah')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            judulDialog(context, 'Ganti Password'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _oldPasswordController,
                      obscureText: true,
                      decoration:
                          const InputDecoration(labelText: 'Kata Sandi Lama'),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     Fluttertoast.showToast(
                      //         msg: 'Kata Sandi Lama harus diisi');
                      //     return;
                      //   }
                      //   return null;
                      // },
                    ),
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration:
                          const InputDecoration(labelText: 'Kata Sandi Baru'),
                      // validator: (value) {
                      //   return null;
                      // },
                    ),
                    const SizedBox(height: 16),
                    // ElevatedButton(
                    //   onPressed: _changePassword,
                    //   child: const Text('Ganti Password'),
                    // ),
                  ],
                ),
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
                  onPressed: () {
                    String oldPassword = _oldPasswordController.text;
                    String newPassword = _newPasswordController.text;
                    if (oldPassword.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Kata Sandi Lama harus diisi');
                      return;
                    }
                    if (newPassword.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Kata Sandi Baru harus diisi');
                      return;
                    }
                    _changePassword;
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
