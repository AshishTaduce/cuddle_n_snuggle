import 'package:cns/New%20Screens%202/profilen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cns/models/event.dart';
import 'package:cns/screens/add_event.dart';
import 'package:cns/services/db_service.dart';
import 'package:cns/util/database_helper.dart';
import 'package:table_calendar/table_calendar.dart';

import 'Message_page.dart';
import 'Welcome_homepage.dart';

class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  // CalendarController _calendarController;
  PageController? _calendarController;
  TextEditingController? _eventController;
  late Map<DateTime, List<EventModel>> _events;
  late final ValueNotifier<List<EventModel>> _selectedEvents;
  SharedPreferences? prefs;
  DbService? dbService;
  DatabaseHelper? databaseHelper;
  bool valueFromAddEvent = false;
  final DateFormat dateFormat = DateFormat("yyyy-mm-dd");

  @override
  void initState() {
    super.initState();
    // _calendarController = PageController();
    _eventController = TextEditingController();
    _events = {};
    // _reloadPage();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    dbService = DbService();
    databaseHelper = DatabaseHelper();
  }

  Map<DateTime, List<EventModel>> _fromModelToEvent(List<EventModel> events) {
    Map<DateTime, List<EventModel>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date]!.add(event);
    });
    return data;
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });

    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  awaitReturnValueFromAddEvent() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEvent(),
        ));
    setState(() {});
  }

  awaitReturnValueFromAddEventForUpdate(EventModel event) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddEvent(
            event: event,
          ),
        ));

    setState(() {
      valueFromAddEvent = result;
    });
  }

  List<EventModel> _getEventsForDay(DateTime day) {
    // Implementation example
    return _events[day] ?? [];
  }

  // _reloadPage() async {
  //   print("reload");
  //   Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(
  //       PageRouteBuilder(
  //         pageBuilder: (_, __, ___) => CalenderPage(),
  //         transitionDuration: Duration(seconds: 0),
  //       ),(Route<dynamic> route) => false);
  // }

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key(valueFromAddEvent.toString()),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Color(0xffff9827),
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.calendar_today_outlined, title: 'Calendar'),
          TabItem(icon: Icons.message, title: 'Message'),
          TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 1, //optional, default as 0

        onTap: (index) {
          if (index == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewScreenSecondHomePage()));
          } else if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CalenderPage()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MessagePage()));
          } else if (index == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          }
        },
      ),
      body: SafeArea(
        child: FutureBuilder<List<EventModel>>(
            future: databaseHelper!.getTaskList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<EventModel>? allEvents = snapshot.data;

                _events = _fromModelToEvent(allEvents!);
              }
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15),
                          Text("All Reminders",
                              style: TextStyle(
                                  fontFamily: 'MyFont',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 40.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: HexColor("#ff9827"),
                          borderRadius: BorderRadius.circular(16)),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: _focusedDay,

                        eventLoader: (event) {
                          // setState(() {
                          //   _selectedEvents =  _events![event] ?? [];
                          // });

                          return _events[event] ?? [];
                        },

                        calendarFormat: CalendarFormat.month,

                        calendarStyle: CalendarStyle(
                          markerDecoration: BoxDecoration(color: Colors.black),
                          todayDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          defaultTextStyle: TextStyle(color: Colors.white),
                          todayTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: HexColor("#f5756c"),
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          weekendTextStyle: TextStyle(color: Colors.white),
                          outsideDaysVisible: false,
                        ),
                        headerStyle: HeaderStyle(
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          titleTextFormatter: (date, locale) =>
                              DateFormat.yMMMM(locale).format(date),
                          formatButtonVisible: false,
                          leftChevronIcon: const Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                          rightChevronIcon: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            weekendStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPageChanged: (focusedDate) {
                          _focusedDay = focusedDate;
                        },
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDate, focusedDate) {
                          bool temp = _events.keys.toList().any(
                                (element) =>
                                    dateFormat.format(element) ==
                                    dateFormat.format(selectedDate),
                              );
                          setState(() {
                            _focusedDay = focusedDate;
                            _selectedDay = selectedDate;
                            _selectedEvents.value = (temp
                                ? _events[_events.keys.toList().firstWhere(
                                      (element) =>
                                          dateFormat.format(element) ==
                                          dateFormat.format(selectedDate),
                                    )]
                                : [])!;
                          });
                        },
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) =>
                              _selectedEvents.value.isEmpty
                                  ? Container()
                                  : Container(
                                      height: 5,
                                      width: 5,
                                      color: Colors.white,
                                    ),
                          selectedBuilder: (context, date, events) => Container(
                              margin: EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(
                                  color: HexColor("#f5756c"),
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          holidayBuilder: (context, date, enevts) => Container(
                              margin: EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.teal.shade300,
                                  shape: BoxShape.circle),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        // : _calendarController,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          'Upcoming Vaccinations',
                          style: TextStyle(
                              fontFamily: 'Arial',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    ..._selectedEvents.value.map((event) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                child: Text(
                              event.pet.toString(),
                              // event.time.toString(),
                              style: TextStyle(fontSize: 16),
                            )),
                            GestureDetector(
                              onTap: () {
                                awaitReturnValueFromAddEventForUpdate(event);
                              },
                              child: Container(
                                  key: Key("$valueFromAddEvent"),
                                  margin: EdgeInsets.only(bottom: 10),
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Color(0xffff9827),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 2),
                                            blurRadius: 2.0)
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Appointment Time -" +
                                            event.time!.format(context),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Appointment For - " +
                                            event.title.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: HexColor("#ff9827"),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          elevation: 4.0,
          onPressed: () {
            awaitReturnValueFromAddEvent();
          }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
