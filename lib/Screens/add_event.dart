import 'package:cns/models/pets.dart';
import 'package:cns/provider/main_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cns/custom_widgets/custom_button.dart';
import 'package:cns/mixins/validation_mixin.dart';
import 'package:cns/models/event.dart';
import 'package:cns/services/db_service.dart';
import 'package:cns/util/database_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cns/main.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  final EventModel? event;

  AddEvent({this.event});
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> with ValidationMixin {
  late DbService dbService;
  late DatabaseHelper databaseHelper;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late DateTime _eventDate;
  late TimeOfDay _time;
  late bool processing;
  String header = "Add New Reminder";
  String buttonText = "Save";
  bool addNewTask = true;
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    dbService = DbService();
    databaseHelper = DatabaseHelper();
    _title = TextEditingController();
    _eventDate = DateTime.now();
    _time = TimeOfDay.now();
    if (widget.event != null) {
      populateForm();
    }
    processing = false;
  }

  void populateForm() {
    _eventDate = widget.event!.eventDate;
    _time = widget.event!.time!;
    header = "Update Appointment";
    buttonText = "Update";
    addNewTask = false;
    setState(() {
      // updatenotification();
    });
  }

  void saveTask() async {
    try {
      if (addNewTask) {
        print(_selectedPet!.petName);
        print("^^^^^^^^^");
        await databaseHelper.addTask(EventModel(
          eventDate: _eventDate,
          time: _time,
          pet: _selectedPet!,
          title: _title.text,
        ));
      } else {
        await databaseHelper.updateTask(EventModel(
            id: widget.event!.id,
            title: _title.text,
            pet: _selectedPet!,
            eventDate: _eventDate,
            time: _time));
      }

      setState(() {
        processing = false;
      });
      await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }

  void deleteTask() async {
    try {
      await databaseHelper.deleteTask(widget.event!.id!);
      setState(() {
        processing = false;
      });
      await _goBack();
    } catch (e) {
      print("Error $e");
    }
  }

  Future<bool> _goBack() async {
    Navigator.of(context).pop(true);
    return false;
  }

  Future<bool> _onBackPressedWithButton() async {
    Navigator.of(context).pop(false);
    return false;
  }

  void scheduleNotification() async {
    var scheduleTime =
        _eventDate.add(Duration(hours: _time.hour - 1, minutes: _time.minute));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'download',
      // sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      // largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutternotificationplugin.schedule(
      1 +
          int.parse(
              scheduleTime.microsecondsSinceEpoch.toString().substring(0, 7)),
      'Reminder',
      'You will be reminded 1 hour before your scheduled appointment',
      DateTime.now().add(
        Duration(seconds: 15),
      ),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
    );
    await flutternotificationplugin.schedule(
      int.parse(scheduleTime.microsecondsSinceEpoch.toString().substring(0, 7)),
      'Reminder',
      'You have upcoming appointment @${widget.event?.title} in 1 hour',
      scheduleTime,
      platformChannelSpecifics,
    );
  }

  PetModel? _selectedPet;

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 300,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 230,
                    child: CupertinoDatePicker(
                      minimumDate: DateTime.now(),
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (val) {
                        setState(() {
                          _eventDate = val;
                        });
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Reminder",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
              icon: Icon(Icons.chevron_left_rounded),
              color: Colors.black,
              iconSize: 32,
              onPressed: () {
                _onBackPressedWithButton();
              }),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: Consumer<MainProvider>(
          builder: (context, provider, _) => Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  child: TextFormField(
                    validator: validateTextInput,
                    decoration: InputDecoration(
                      labelText: "Remainder Name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: DropdownButtonFormField(
                    validator: (value) =>
                        value == null ? "Please select a pet." : null,
                    decoration: InputDecoration(
                      labelText: "Select Pet",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    items: provider.myPets
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.petName),
                          ),
                        )
                        .toList(),
                    onChanged: (PetModel? newPet) {
                      setState(() {
                        _selectedPet = newPet;
                      });
                    },
                    value: _selectedPet,
                  ),
                ),
                // SizedBox(height: 10.0),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "Select Time",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: Text(
                      "${_time.hourOfPeriod}:${_time.minute} ${_time.period == DayPeriod.am ? "AM" : "PM"}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Center(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        height: 150,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (val) {
                            setState(() {
                              _time = TimeOfDay.fromDateTime(val);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "Select Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    trailing: Text(
                      "${_eventDate.day} "
                      "${DateFormat('MMM').format(_eventDate)} "
                      "${_eventDate.year}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () => _showDatePicker(context),
                  ),
                ),
                SizedBox(height: 10.0),
                processing
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            CustomButton(
                              buttonColor: Color(0xfffe812d),
                              buttonText: buttonText,
                              width: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    processing = true;
                                  });
                                  saveTask();
                                  // scheduleNotification();
                                }
                              },
                              key: Key("B"),
                              buttonIcon: Text("Update"),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              child: !addNewTask
                                  ? CustomButton(
                                      buttonText: "Delete",
                                      width: MediaQuery.of(context).size.width,
                                      buttonColor: Colors.redAccent,
                                      onPressed: () async {
                                        setState(() {
                                          processing = true;
                                        });
                                        deleteTask();
                                      },
                                      buttonIcon: Text("Delete"),
                                      key: Key("L"),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
