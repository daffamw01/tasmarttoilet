import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar2/flutter_clean_calendar.dart';
import 'package:intl/intl.dart';
import 'package:tasmarttoilet/reusable_widget/reusable_widget.dart';

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  late DateTime selectedDay;
  late List<CleanCalendarEvent> selectedEvent;
  late ValueChanged<CleanCalendarEvent>? onEventSelected;

  final Map<DateTime, List<CleanCalendarEvent>> events = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue),
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
        [
      CleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],
  };

  void _handleData(date) {
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedDay = DateTime.now();
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Card(
            margin: const EdgeInsets.all(10),
            child: Calendar(
              startOnMonday: true,
              selectedColor: Colors.blue,
              todayColor: Colors.red,
              eventColor: Colors.green,
              eventDoneColor: Colors.amber,
              bottomBarColor: Colors.deepOrange,
              onRangeSelected: (range) {
                print('selected Day ${range.from},${range.to}');
              },
              onDateSelected: (date) {
                return _handleData(date);
              },
              events: events,
              isExpanded: true,
              dayOfWeekStyle: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                // fontWeight: FontWeight.w100,
              ),
              bottomBarTextStyle: const TextStyle(
                color: Colors.white,
              ),
              hideBottomBar: false,
              hideArrows: false,
              weekDays: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
              eventListBuilder: (context, events) {
                return Expanded(
                    child: selectedEvent.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              CleanCalendarEvent event = selectedEvent[index];
                              final String start = DateFormat('HH:mm')
                                  .format(event.startTime)
                                  .toString();
                              final String end = DateFormat('HH:mm')
                                  .format(event.endTime)
                                  .toString();
                              return SizedBox(
                                height: 60,
                                child: InkWell(
                                  onTap: () {
                                    if (onEventSelected != null) {
                                      onEventSelected!(event);
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                          flex: 5,
                                          child: Padding(
                                              padding: const EdgeInsets.all(4),
                                              child: Container(
                                                  color: event.color))),
                                      Expanded(
                                          flex: 75,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  event.summary,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                Text(event.description)
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                          flex: 20,
                                          child: Padding(
                                            padding: const EdgeInsets.all(9),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  start,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                                Text(
                                                  end,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: selectedEvent.length,
                          )
                        : Container());
              },
            ),
          ),
        ],
      ),
    );
  }
}
