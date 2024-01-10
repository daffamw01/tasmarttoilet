import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:tasmarttoilet/models/User_Model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasmarttoilet/services/firebaseApi.dart';
import 'package:tasmarttoilet/view/Account_Page.dart';
import 'package:tasmarttoilet/view/Admin_Page.dart';
import 'package:tasmarttoilet/view/JadwalPegawai_Page.dart';
import 'dart:convert';

import 'package:tasmarttoilet/view/Login_Page.dart';
import 'package:tasmarttoilet/view/Monitoring_Page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterBlue.instance;
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            } else if (snapshot.hasData) {
              return const MainPage();
            } else {
              return const loginpage();
            }
          },
        ),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  String userRole = "";

  @override
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
          final userData = UserModel.fromJson(
              json.decode(json.encode(dataSnapshot.snapshot.value)));
          setState(() {
            userRole = userData.position;
          });
        }
      }
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    const itemsAdmin = [
      Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
      Icon(Icons.calendar_month_outlined, size: 30, color: Color(0XFF084B72)),
      Icon(Icons.admin_panel_settings_outlined,
          size: 30, color: Color(0XFF084B72)),
      Icon(Icons.account_box_outlined, size: 30, color: Color(0XFF084B72)),
    ];
    const itemsPetugas = [
      Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
      Icon(Icons.calendar_month_outlined, size: 30, color: Color(0XFF084B72)),
      Icon(Icons.account_box_outlined, size: 30, color: Color(0XFF084B72)),
    ];
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text('Smart Toilet'),
        backgroundColor: const Color(0XFF003452),
      ),
      bottomNavigationBar: userRole == 'Admin'
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: bottombar(icons: itemsAdmin))
          : bottombar(icons: itemsPetugas),
      body: userRole == 'Admin'
          ? getSelectedWidgetAdmin(index: index)
          : getSelectedWidget(index: index),
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
      backgroundColor: const Color(0XFF084B72),
      height: 50,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  Widget getSelectedWidget({
    required int index,
  }) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const MonitoringPegawai();
        break;
      case 1:
        widget = const CalendarTry();
        break;
      case 2:
        widget = const AccountPage();
        break;
      default:
        widget = const MonitoringPegawai();
        break;
    }
    return widget;
  }

  Widget getSelectedWidgetAdmin({
    required int index,
  }) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const MonitoringPegawai();
        break;
      case 1:
        widget = const CalendarTry();
        break;
      case 2:
        widget = const AdminPage();
        break;
      case 3:
        widget = const AccountPage();
        break;
      default:
        widget = const MonitoringPegawai();
        break;
    }
    return widget;
  }
}
