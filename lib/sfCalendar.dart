import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasmarttoilet/models/schedule_model.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';

class CalendarTry extends StatefulWidget {
  const CalendarTry({super.key});

  @override
  State<CalendarTry> createState() => _CalendarTryState();
}

class _CalendarTryState extends State<CalendarTry> {
  final _database = FirebaseDatabase.instance;
  final List<Meeting> _appointments = <Meeting>[];
  final bool _isLoading = true;
  // CalendarController _calendarController = CalendarController();
  // final CalendarFormat _calendarFormat = CalendarFormat.week;
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  // late DateTime _selectedDay;
  late Map<DateTime, List<ScheduleModel>> _events;
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<ScheduleModel> events = [];
  late CalendarView _calendarView;

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _calendarView = CalendarView.schedule;
    loadEventsFromFirestore();
    // _loadFirestoreSchedules();
    // _focusedDay = DateTime.now();
    // _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    // _lastDay = DateTime.now().add(const Duration(days: 1000));
    // _selectedDay = DateTime.now();
  }

  // _loadFirestoreSchedules() async {
  //   final snap = await FirebaseFirestore.instance
  //       .collection('schedule')
  //       .withConverter(
  //           fromFirestore: ScheduleModel.fromFirestore,
  //           toFirestore: (event, options) => event.toFirestore())
  //       .get();
  //   for (var doc in snap.docs) {
  //     final event = doc.data();
  //     final day = DateTime(event.date.year, event.date.month, event.date.day);
  //     if (_events[day] == null) {
  //       _events[day] = [];
  //     }
  //     _events[day]!.add(event);
  //   }
  //   setState(() {});
  // }

  // List _getSchedulesForTheDay(DateTime day) {
  //   return _events[day] ?? [];
  // }

  // Future<List<ScheduleModel>> getSchedulesFromFirestore() async {
  //   // List<ScheduleModel> events = [];
  //   QuerySnapshot eventSnapshot =
  //       await FirebaseFirestore.instance.collection('schedule').get();
  //   eventSnapshot.docs.forEach((DocumentSnapshot doc) {
  //     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //     events.add(ScheduleModel.fromFirestore(data));
  //   });
  //   return events;
  // }

  Future<void> loadEventsFromFirestore() async {
    QuerySnapshot eventSnapshot =
        await FirebaseFirestore.instance.collection('schedule').get();
    events = eventSnapshot.docs
        .map((DocumentSnapshot doc) =>
            ScheduleModel.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  children: [
                    // SfCalendar(
                    //   view: CalendarView.month,
                    //   monthViewSettings: const MonthViewSettings(
                    //     showAgenda: false,
                    //     agendaViewHeight: 60,
                    //     // agendaItemHeight: 60,
                    //     navigationDirection: MonthNavigationDirection.vertical,
                    //     appointmentDisplayMode:
                    //         MonthAppointmentDisplayMode.indicator,
                    //     // agendaStyle:
                    //     //     AgendaStyle(backgroundColor: Colors.blueAccent)
                    //   ),
                    // ),
                    Expanded(
                      child: SfCalendar(
                        view: _calendarView,
                        headerHeight: 50,
                        // minDate: _focusedDay,

                        dataSource: EventDataSource(events),
                        scheduleViewSettings: const ScheduleViewSettings(
                            monthHeaderSettings: MonthHeaderSettings(
                                height: 70,
                                textAlign: TextAlign.left,
                                backgroundColor: Color(0XFF00799F)),
                            appointmentItemHeight: 50,
                            appointmentTextStyle: TextStyle(fontSize: 16),
                            hideEmptyScheduleWeek: false),
                        appointmentBuilder:
                            (context, CalendarAppointmentDetails details) {
                          if (details.appointments.isNotEmpty) {
                            final appointment = details.appointments.first;
                            return Container(
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: RandomPastelColor(),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                appointment.subject ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                        // viewNavigationMode: ViewNavigationMode.none,
                      ),
                    )
                    // SfCalendar(
                    //   view: CalendarView.timelineMonth,
                    //   headerHeight: 0,
                    // )
                  ],
                ),
              ),
            ],
          )
          // SfCalendar(
          //   view: CalendarView.timelineMonth,
          //   // firstDayOfWeek: ,
          // ),
        ],
      ),
    );
  }
}

class Meeting {
  Meeting(this.subject, this.color);

  String subject;
  Color color;

  factory Meeting.fromJson(Map<dynamic, dynamic> json) {
    return Meeting(json['subject'], Color(int.parse(json['color'])));
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<ScheduleModel> source) {
    appointments = source
        .map((event) => Appointment(
              startTime: event.date,
              endTime: event.date.add(const Duration(hours: 1)),
              subject: event.fullName,
              isAllDay: true,
            ))
        .toList();
  }
}
