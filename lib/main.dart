import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:clock_app/alarmpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'dart:isolate';
// import 'dart:math';
import 'dart:ui';

// import 'package:android_alarm_manager/android_alarm_manager.dart';
// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The [SharedPreferences] key to access the alarm fire count.
const String countKey = 'count';

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();

/// Global [SharedPreferences] object.
SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );
  prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(countKey)) {
    await prefs.setInt(countKey, 0);
  }
  runApp(AlarmApp());
}

class AlarmApp extends StatefulWidget {
  _AlarmAppState createState() => _AlarmAppState();
}

class _AlarmAppState extends State<AlarmApp> {
  @override
  void initState() {
    // TODO: implement initState
    AndroidAlarmManager.initialize();
    // _getAlarmlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xFF000000), accentColor: Color(0xff65D1BA)),
        debugShowCheckedModeBanner: false,
        home: AlarmPage());
  }
}

_getAlarmlist() async {}

class AlarmTime {
  List<bool> days;
  TimeOfDay time;
  bool active = true;
  AlarmTime({this.days, this.time, this.active});
}

SharedPreferences sharedPreferences;
List<AlarmTime> alarmlist = [];
int alarmcount = alarmlist.length;
AlarmTime tempalarm = AlarmTime();

alarmon(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Alarm",
    buttons: [
      DialogButton(
        child: Text(
          "STOP",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          Navigator.pop(context);
          FlutterRingtonePlayer.stop();
        },
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "SNOOZE",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          Navigator.pop(context);
          FlutterRingtonePlayer.stop();
        },
      )
    ],
  ).show();
}

timeralarm(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "TIME OUT",
    buttons: [
      DialogButton(
        child: Text(
          "STOP",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
          FlutterRingtonePlayer.stop();
        },
        width: 120,
      )
    ],
  ).show();
}

List<String> timeZone = [
  "Greenwich Mean Time",
  "Universal Coordinated Time",
  "European Central Time",
  "Eastern European Time",
  "(Arabic) Egypt Standard Time",
  "Eastern African Time",
  "Middle East Time",
  "Near East Time",
  "Pakistan Lahore Time",
  "India Standard Time",
  "Bangladesh Standard Time",
  "Vietnam Standard Time",
  "China Taiwan Time",
  "Japan Standard Time",
  "Australia Central Time",
  "Australia Eastern Time",
  "Solomon Standard Time",
  "New Zealand Standard Time",
  "Midway Islands Time",
  "Hawaii Standard Time",
  "Alaska Standard Time",
  "Pacific Standard Time",
  "Phoenix Standard Time",
  "Mountain Standard Time",
  "Central Standard Time",
  "Eastern Standard Time",
  "Indiana Eastern Standard Time",
  "Puerto Rico and US Virgin Islands Time",
  "Canada Newfoundland Time",
  "Argentina Standard Time",
  "Brazil Eastern Time",
  "Central African Time",
];
List<int> hour = [
  -5,
  -5,
  -4,
  -3,
  -3,
  -2,
  -2,
  -1,
  0,
  0,
  0,
  1,
  2,
  3,
  4,
  4,
  5,
  6,
  -16,
  -15,
  -14,
  -13,
  -12,
  -12,
  -11,
  0,
  0,
  -1,
  -2,
  -2,
  -2,
  -4,
];
List<int> min = [
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  0,
  -30,
  -30,
  0,
  30,
  30,
  30,
  30,
  0,
  30,
  30,
  30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  -30,
  0,
  -30,
  -30,
  -30,
];
