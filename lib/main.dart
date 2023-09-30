import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasmarttoilet/AccountDrawer.dart';
import 'package:tasmarttoilet/AdminPage.dart';
import 'package:tasmarttoilet/JadwalPegawai.dart';
import 'package:tasmarttoilet/MonitoringPegawai.dart';
import 'package:tasmarttoilet/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:tasmarttoilet/monitoringpegawai.dart';
// import 'package:tasmarttoilet/splash.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//
class MyApp extends StatelessWidget {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => MaterialApp(
        // navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!'));
            } else if (snapshot.hasData) {
              return MainPage();
            } else {
              return loginpage();
            }
            // if (snapshot.hasData) {
            //   // Pengguna sudah masuk
            //   return MainPage();
            // } else {
            //   // Pengguna belum masuk
            //   return loginpage();
            // }
            // }
          },
        ),
        // initialRoute: '/login',
        // routes: {
        //   '/login': (context) => loginpage(),
        //   'main': (context) => MainPage(),
        // },
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final items = const [
    Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
    Icon(Icons.calendar_month_outlined, size: 30, color: Color(0XFF084B72)),
    Icon(Icons.account_box_outlined, size: 30, color: Color(0XFF084B72))
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AccountDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        backgroundColor: Color(0XFF084B72),
        height: 50,
        animationDuration: const Duration(milliseconds: 500),
      ),
      body: getSelectedWidget(index: index),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const MonitoringPegawai();
        break;
      case 1:
        widget = const JadwalPegawai();
        break;
      case 2:
        widget = const AdminPage();
        break;
      default:
        widget = const MonitoringPegawai();
        break;
    }
    return widget;
  }
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int index = 0;

//   @override
//   Widget build(BuildContext context) {
//     final items = const [
//       Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
//       Icon(Icons.calendar_month_outlined, size: 30, color: Color(0XFF084B72)),
//       Icon(Icons.account_box_outlined, size: 30, color: Color(0XFF084B72))
//     ];

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/login',
//       routes: {
//         '/login': (context) => loginpage(),
//         '/main': (context) => Scaffold(
//               body: getSelectedWidget(index: index),
//               bottomNavigationBar: CurvedNavigationBar(
//                 items: items,
//                 index: index,
//                 onTap: (selectedIndex) {
//                   setState(() {
//                     index = selectedIndex;
//                   });
//                 },
//                 backgroundColor: Color(0XFF084B72),
//                 height: 50,
//                 animationDuration: const Duration(milliseconds: 500),
//               ),
//             ),
//       },
//     );
//   }

//   Widget getSelectedWidget({required int index}) {
//     Widget widget;
//     switch (index) {
//       case 0:
//         widget = const MonitoringPegawai();
//         break;
//       case 1:
//         widget = const JadwalPegawai();
//         break;
//       case 2:
//         widget = const AdminPage();
//         break;
//       default:
//         widget = const MonitoringPegawai();
//         break;
//     }
//     return widget;
//   }
// }



// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int index = 0;

//   @override
//   Widget build(BuildContext context) {
//     final items = const [
//       Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
//       Icon(Icons.calendar_month_outlined, size: 30, color: Color(0XFF084B72)),
//       Icon(Icons.account_box_outlined, size: 30, color: Color(0XFF084B72))
//     ];

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/login',
//       routes: {
//         '/login': (context) => loginpage(),
//         '/main': (context) => Scaffold(
//               body: getSelectedWidget(index: index),
//               bottomNavigationBar: CurvedNavigationBar(
//                 items: items,
//                 index: index,
//                 onTap: (selectedIndex) {
//                   setState(() {
//                     index = selectedIndex;
//                   });
//                 },
//                 backgroundColor: Color(0XFF084B72),
//                 height: 50,
//                 animationDuration: const Duration(milliseconds: 500),
//               ),
//             ),
//       },
//     );
//   }

//   Widget getSelectedWidget({required int index}) {
//     Widget widget;
//     switch (index) {
//       case 0:
//         widget = const MonitoringPegawai();
//         break;
//       case 1:
//         widget = const JadwalPegawai();
//         break;
//       case 2:
//         widget = const AdminPage();
//         break;
//       default:
//         widget = const MonitoringPegawai();
//         break;
//     }
//     return widget;
//   }
// }
