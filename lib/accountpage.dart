import 'package:flutter/material.dart';

void main() {
  runApp(AccountPage());
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color(0xFF003452),
        ),
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
                  padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, left: 10, bottom: 20),
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          "Hai, Selamat Datang Daffa!",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SansPro',
                            fontSize: MediaQuery.of(context).size.width * 0.065,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 600,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [],
                        ),
                      )
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
