import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
              // final user = snapshot.data;
              // if (user != null) {

              // }
              // }
              // final user = snapshot.data!;
              // DatabaseReference userRef = FirebaseDatabase.instance
              //     .ref()
              //     .child("users")
              //     .child(user.uid);
              // userRef.once().then((DataSnapshot snapshot) {
              //   if (snapshot.value != null) {
              //     Map<dynamic, dynamic> userData = snapshot.value;
              //     String userPosition = userData["posisi"];

              //     if (userPosition == 'admin') {
              //       return AdminPage();
              //     } else {
              //       return MonitoringPegawai();
              //     }
              //   }
              // },)
              // User? user = snapshot.data;
              // String? userPosition;

              // if (user != null) {
              //   DatabaseReference userRef = FirebaseDatabase.instance
              //       .ref()
              //       .child("users")
              //       .child(user.uid);
              //   userRef.once().then((DataSnapshot snapshot) {
              //     if (snapshot.value != null) {
              //       Map<dynamic, dynamic> userData = snapshot.value;
              //       String userPosition
              //     }
              //   });
              // }
              // final userRole = "Admin";
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
  // final String userRole;
  // MainPage({required this.userRole});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // List<Icon> itemsadmin = [
  //   Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
  //   Icon(Icons.calendar_month_outlined, size: 30, color: Color(0XFF084B72)),
  //   Icon(Icons.account_box_outlined, size: 30, color: Color(0XFF084B72))
  // ];
  // List<Icon> itemspetugas = [
  //   Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
  //   Icon(Icons.calendar_month_outlined, size: 30, color: Color(0XFF084B72)),
  //   // Icon(Icons.account_box_outlined, size: 30, color: Color(0XFF084B72))
  // ];

  // List<Icon> currentNavItems = [];

  int index = 1;
  String userRole = "";

  void initState() {
    super.initState();
    getUserPosition();
  }

  Future<void> getUserPosition() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final databaseReference = FirebaseDatabase.instance.ref();
        final userRef = databaseReference.child("users").child(user.uid);
        final dataSnapshot = await userRef.once();

        if (dataSnapshot.snapshot.value != null) {
          final userData =
              await dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
          final userPosition = userData['position'] as String;
          setState(() {
            userRole = userPosition;
          });
        }
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemsAdmin = const [
      Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
      Icon(Icons.calendar_month_outlined, size: 30, color: Color(0XFF084B72)),
      Icon(Icons.account_box_outlined, size: 30, color: Color(0XFF084B72)),
    ];
    final itemsPetugas = const [
      Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
      Icon(Icons.calendar_month_outlined, size: 30, color: Color(0XFF084B72)),
      // Icon(Icons.account_box_outlined, size: 30, color: Color(0XFF084B72))
    ];
    // List<Icon> itemsToShow;
    // if (userRole == 'Admin') {
    //   itemsToShow = itemsadmin;
    // } else {
    //   itemsToShow = itemspetugas;
    // }

    final itemsToShow = userRole == 'Admin' ? itemsAdmin : itemsPetugas;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text('Smart Toilet'),
        backgroundColor: Color(0XFF003452),
      ),
      drawer: AccountDrawer(),
      bottomNavigationBar: userRole == 'Admin'
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: bottombar(icons: itemsAdmin))
          : bottombar(icons: itemsPetugas),
      body: getSelectedWidget(index: index), //userRole: widget.userRole!),
    );
  }

  Widget bottombar({
    required List<Widget> icons,
  }) {
    return CurvedNavigationBar(
      items: icons,
      index: index,
      onTap: (selectedIndex) {
        setState(() {
          index = selectedIndex;
        });
      },
      backgroundColor: Color(0XFF084B72),
      height: 50,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  Widget getSelectedWidget({
    required int index,
  }) {
    print(index);
    //required String userRole
    Widget widget;
    // final userRole = '';
    switch (index) {
      case 0:
        widget = const MonitoringPegawai();
        break;
      case 1:
        widget = const JadwalPegawai();
        break;
      case 2:
        // if (userRole == 'Admin') {
        //   widget = const AdminPage();
        // } else {
        //   widget = const Placeholder();
        // }
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
