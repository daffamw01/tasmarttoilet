// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
// import 'package:tasmarttoilet/MonitoringPegawai.dart';
// import 'package:tasmarttoilet/MonitoringPegawai.dart';

// void main() {
//   runApp(JadwalPegawai());
// }

class ListItem {
  final String day;
  final String date;
  final String name;
  final String imagePath;
  final Color backgroundColor;

  ListItem({
    required this.day,
    required this.date,
    required this.name,
    required this.imagePath,
    required this.backgroundColor,
  });
}

class ListMinggu {
  final String totalWeek;

  ListMinggu({required this.totalWeek});
}

class JadwalPegawai extends StatefulWidget {
  const JadwalPegawai({super.key});

  @override
  State<JadwalPegawai> createState() => _JadwalPegawaiState();
}

class _JadwalPegawaiState extends State<JadwalPegawai> {
  final List<ListItem> data = [
    ListItem(
        day: 'Senin',
        date: '04/09/2023',
        name: 'M. Suryanto',
        imagePath: 'images/sudahabsen1.png',
        backgroundColor: Color(0XFF003452)),
    ListItem(
        day: 'Selasa',
        date: '05/09/2023',
        name: 'Ahmad Saipul',
        imagePath: 'images/sudahabsen1.png',
        backgroundColor: Color(0XFF084B72)),
    ListItem(
        day: 'Rabu',
        date: '06/09/2023',
        name: 'Syaifudin K.',
        imagePath: 'images/sudahabsen1.png',
        backgroundColor: Color(0XFF003452)),
    ListItem(
        day: 'Kamis',
        date: '07/09/2023',
        name: 'M. Suryanto',
        imagePath: 'images/belumabsen1.png',
        backgroundColor: Color(0XFF084B72)),
    ListItem(
        day: 'Jumat',
        date: '08/09/2023',
        name: 'Ahmad Saipul',
        imagePath: 'images/belumabsen1.png',
        backgroundColor: Color(0XFF003452)),
    ListItem(
        day: 'Sabtu',
        date: '09/09/2023',
        name: 'Syaifudin K.',
        imagePath: 'images/belumabsen1.png',
        backgroundColor: Color(0XFF084B72)),
    ListItem(
        day: 'Minggu',
        date: '10/09/2023',
        name: 'M. Suryanto',
        imagePath: 'images/belumabsen1.png',
        backgroundColor: Color(0XFF003452)),
  ];

  final List<ListMinggu> weekData = [
    ListMinggu(totalWeek: '1'),
    ListMinggu(totalWeek: '2'),
    ListMinggu(totalWeek: '3'),
    ListMinggu(totalWeek: '4'),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(0),
          child: Stack(
            children: [
              Image.asset(
                'images/background.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              SingleChildScrollView(
                child: Center(
                  // padding: EdgeInsets.all(0),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: 20), //pake appbar 10 kalo gapake 50
                    child: Column(
                      children: [
                        Container(
                          // BASE CONTAINER DASAR
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          height: 755,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(top: 5, bottom: 10),
                                child: Text(
                                  'Jadwal Petugas',
                                  style: TextStyle(
                                      fontFamily: 'SansPro',
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
//////////////////////////////////////////////////////////////////////////      SENIN     ////////////////////////////////////////////////////////////////
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final item = data[index];
                                  return Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          // width: 315,
                                          width: 93,
                                          // MediaQuery.of(context)
                                          //         .size
                                          //         .width -
                                          //     265,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: item.backgroundColor,
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 3),
                                                ),
                                              ]),
                                          // alignment: Alignment.,
                                          padding: EdgeInsets.only(
                                              left: 0, right: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(top: 10
                                                    // MediaQuery.of(context)
                                                    //         .size
                                                    //         .width *
                                                    //     0.03,
                                                    ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    250,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  item.day,
                                                  // textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'SansPro',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.053),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    250,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  item.date,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'SansPro',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.035),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 90),
                                              child: Container(
                                                // width: 240,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    120,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                    color: Color(0XFFFFFFFF),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 2.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: Offset(0, 3),
                                                      )
                                                    ]),
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        item.name,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'SansPro',
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: Image.asset(
                                                              item.imagePath,
                                                              width: 48,
                                                              height: 48,
                                                            ))),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //   width: 240,
                                            //   height: 70,
                                            //   alignment: Alignment.centerLeft,
                                            //   padding: EdgeInsets.only(left: 110),
                                            //   child: Text(
                                            //     'M. Suryanto',
                                            //     style: TextStyle(
                                            //         fontFamily: 'SansPro',
                                            //         fontSize: 18,
                                            //         color: Colors.black),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 5);
                                },
                              ),
//////////////////////////////////////////////////////////////////////////      KOTAK MINGGU      /////////////////////////////////////////////////////////
                              // Minggu ke-1
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 10),
                                child: Row(
                                  children: weekData.map((week) {
                                    return Container(
                                      width: 70,
                                      height: 70,
                                      margin: EdgeInsets.only(
                                          right:
                                              10), // Tambahkan margin antara kotak minggu
                                      decoration: BoxDecoration(
                                        color: Color(0XFFD9D9D9),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(2, 4),
                                          )
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Minggu Ke-' + week.totalWeek,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'SansPro',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: CurvedNavigationBar(
        //     backgroundColor: Color(0XFF084B72),
        //     height: 50,
        //     items: <Widget>[
        //       Icon(Icons.monitor, size: 30, color: Color(0XFF084B72)),
        //       Icon(Icons.calendar_month_outlined,
        //           size: 30, color: Color(0XFF084B72)),
        //     ],
        //     animationDuration: Duration(milliseconds: 1000),
        //     onTap: (index) {
        //       if (index == 0) {
        //         Navigator.pop(
        //           context,
        //           // MaterialPageRoute(builder: (context) => MonitoringPegawai()),
        //         );
        //       } else if (index == 1) {}
        //     }),
      ),
    );
  }
}
