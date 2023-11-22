import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // CalendarController _calendarController = CalendarController();
  late CalendarFormat _calendarFormat;
  // late CalendarController _calendarController; //
  // late Map<DateTime, List<dynamic>> _events; //
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  // late DateTime _selectedDay;
  late Map<DateTime, List<String>> _events;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.week;
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    // _selectedDay = DateTime.now();
    _events = _generateEvents(_firstDay, _lastDay);
    // _events = {
    //   DateTime(2023, 10, 15): ['Event 1', 'Event 2'],
    //   DateTime(2023, 10, 20): ['Event 3'],
    //   DateTime(2023, 10, 25): ['Event 4'],
    // };
  }

  Map<DateTime, List<String>> _generateEvents(DateTime start, DateTime end) {
    Map<DateTime, List<String>> events = {};

    for (DateTime date = start;
        date.isBefore(end);
        date = date.add(const Duration(days: 1))) {
      events[date] = ['Event for $date'];
    }
    return events;
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    print('Disini');
    print(_getEventsForDay(_focusedDay));
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Column(
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                child: TableCalendar(
                  calendarFormat: _calendarFormat,
                  availableCalendarFormats: const {
                    CalendarFormat.week: '2 Weeks',
                    CalendarFormat.month: 'Week',
                    CalendarFormat.twoWeeks: 'Month'
                  },
                  focusedDay: _focusedDay,
                  firstDay: _firstDay,
                  lastDay: _lastDay,
                  selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  eventLoader: _getEventsForDay,
                  // weekendDays: const [6],
                  // calendarStyle: const CalendarStyle(
                  //     defaultDecoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(20)),
                  // )),
                  headerStyle: const HeaderStyle(
                    decoration: BoxDecoration(color: Color(0XFF91C2BA)),
                    headerMargin: EdgeInsets.only(bottom: 8),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      // _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                      _calendarFormat = CalendarFormat.month;
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (events.isNotEmpty) {
                        Column(
                          children: [Positioned(child: _buildEventsMarker())],
                        );
                      }
                      return null;
                    },
                  ),

                  // },
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Expanded(
                  child: ListView.builder(
                itemCount: _getEventsForDay(_focusedDay).length,
                itemBuilder: (context, index) {
                  final event = _getEventsForDay(_focusedDay)[index];
                  return ListTile(
                    title: Text(event),
                  );
                },
              )),
              // const SingleChildScrollView(
              //   child: Card(child: EventList()),
              // )
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

Widget _buildEventsMarker() {
  return Container(
    width: 80,
    height: 20,
    decoration: const BoxDecoration(
        color: Colors.blue, shape: BoxShape.rectangle, borderRadius: null),
  );
}
