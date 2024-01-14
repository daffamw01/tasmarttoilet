import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasmarttoilet/models/schedule_model.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';

class CalendarTry extends StatefulWidget {
  const CalendarTry({super.key});

  @override
  State<CalendarTry> createState() => _CalendarTryState();
}

class _CalendarTryState extends State<CalendarTry> {
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<ScheduleModel> events = [];
  late CalendarView _calendarView;

  @override
  void initState() {
    super.initState();
    _calendarView = CalendarView.schedule;
    loadEventsFromFirestore();
  }

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
                    Expanded(
                      child: SfCalendar(
                        view: _calendarView,
                        headerHeight: 50,
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
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
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
              subject:
                  '${event.presensi == 'Sudah Presensi' ? '✅' : '❎'} ${event.fullName}',
              isAllDay: true,
            ))
        .toList();
  }
}
