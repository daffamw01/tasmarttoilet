import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tasmarttoilet/AdminPage.dart';
import 'package:tasmarttoilet/main.dart';
// import 'package:tasmarttoilet/services/auth.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

// void main() {
//   runApp(loginpage());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: loginpage(),
//     );
//   }
// }

class loginpage extends StatefulWidget {
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  // final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _obscureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: [
              Image.asset(
                'images/background3.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 0.0),
                      Image.asset(
                        'images/login.png',
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(1),
                          borderRadius: BorderRadius.circular(30.0),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.3),
                          //     spreadRadius: 2,
                          //     blurRadius: 5,
                          //     offset: Offset(0, 3),
                          //    ),
                          // ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                'Sign In',
                                selectionColor: Colors.black,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27.0,
                                  fontFamily: 'SansPro',
                                ),
                              ),
                              SizedBox(height: 0.0),
                              TextField(
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                ),
                              ),
                              SizedBox(height: 0.0),
                              TextField(
                                controller: passwordController,
                                textInputAction: TextInputAction.done,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey),
                                    )),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: signIn,
                                // () {
                                // dynamic result = await _auth.signInAnon();
                                // if (result == null) {
                                //   print('error signing in');
                                // } else {
                                //   print('signed in');
                                //   print(result);

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MainPage()));
                                // },
                                child: Text(
                                  'Login',
                                  selectionColor: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  backgroundColor: Color(0xFF4F52FF),
                                  minimumSize: Size(340, 40),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      // Navigator.of(context).pop();

      // final userId = userCredential.user?.uid;
      // final userRole = await getUserRoleFromDatabase(userId);

      // if (userRole == "Admin") {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => AdminPage()));
      // } else {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => MainPage()),
      //   );
      // }
      // Kembali ke halaman awal
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Terjadi kesalahan saat masuk. Silakan coba lagi.'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
    Navigator.of(context).pop();
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

// Future<String?> getUserRoleFromDatabase(String? userId) async {
//   if (userId != null) {
//     DatabaseReference userRef =
//         FirebaseDatabase.instance.ref().child('users').child(userId);
//     DataSnapshot snapshot = await userRef.once() as DataSnapshot;
//     return (snapshot.value as Map<String, dynamic>)['position'];
//   }
//   return null;
// }

// class PageCoba extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//           title: Text('Bismillah Coba ae'),
//         ),
//         body: Center(
//           child: Image.asset('images/dht.png'),
//         ),
//       ),
      
//     );
//   }
// }