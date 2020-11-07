import 'dart:async';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:clock_app/home.dart';
import 'package:day_selector/day_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  String _timenow;
  String _datenow;
  int _daynow;
  ValueChanged<TimeOfDay> selectTime;
  List<bool> selected = [false, false, false, false, false, false, false];

  @override
  void initState() {
    // selectedTime =
    //     new TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    selectedTime = new TimeOfDay.fromDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());

    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timenow = formattedDateTime;
      _datenow = DateTime.now().day.toString() +
          "  " +
          DateTime.now().month.toString() +
          "  " +
          DateTime.now().year.toString();
      _daynow = now.weekday;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      _timenow.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      daynow(_daynow),
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      _datenow,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: alarmcount,
                  itemBuilder: (BuildContext context, int count) => ListTile(
                        title: Text(
                          timeonalarmtile(alarmlist[count].time),
                          // alarmlist[count].time.toString(),
                          style: TextStyle(
                              color: Color(0xff65D1BA),
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        subtitle: subtitleonalarmtile(count),
                        trailing: Switch(
                          value: switchonalarmtile(alarmlist[count].active),
                          // alarmlist[count].active,
                          onChanged: (bool newappstate) async {
                            // final prefs = await SharedPreferences.getInstance();
                            // final key = 'lockState';
                            // final value = newappstate;
                            // prefs.setBool(key, value);
                            setState(() {
                              alarmlist[count].active = newappstate;
                            });
                          },
                        ),
                        contentPadding: EdgeInsets.all(10),
                        tileColor: Colors.grey[900],
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(400)),
                                  elevation: 16,
                                  child: Container(
                                    height: 400.0,
                                    width: 360.0,
                                    child: Container(
                                      color: Colors.grey[900],
                                      child: alarmEditor(context, count),
                                    ),
                                  ));
                            },
                          );
                        },
                      )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(400)),
                  elevation: 16,
                  child: Container(
                    height: 400.0,
                    width: 360.0,
                    child: Container(
                      color: Colors.grey[900],
                      child: alarmCreator(context),
                    ),
                  ));
            },
          );
        },
        backgroundColor: Color(0xff65D1BA),
        child: Icon(
          Icons.add,
          size: 20.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Scaffold alarmCreator(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(backgroundColor: Colors.grey[900]),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  new GestureDetector(
                    child: Text(
                      selectedTime.format(context),
                      style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _selectTime(context);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal, child: daySelector()),
                  SizedBox(
                    height: 30.0,
                  ),
                  FlatButton(
                      color: Theme.of(context).accentColor,
                      child:
                          Text('Save', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          AlarmTime tmp = AlarmTime();
                          tmp.days = selected;
                          tmp.time = selectedTime;
                          tmp.active = true;
                          alarmlist.add(tmp);
                          // tempalarm.days = selected;
                          // alarmlist.add(tempalarm);
                          alarmcount = alarmlist.length;
                        });
                        Navigator.of(context).pop();
                      })
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Colors.white,
          child: Icon(
            Icons.delete,
            size: 20.0,
            color: Theme.of(context).accentColor,
          ),
        ));
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    setState(() {
      selectedTime = picked;
      // tempalarm.time = picked;
    });
  }

  switchonalarmtile(bool active) {
    if (active == null) {
      return false;
    } else {
      return active;
    }
  }

  Scaffold alarmEditor(BuildContext context, int count) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(backgroundColor: Colors.grey[900]),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.0,
                  ),
                  new GestureDetector(
                    child: Text(
                      selectedTime.format(context),
                      style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _selectTime(context);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: daySelector(),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  FlatButton(
                      color: Theme.of(context).accentColor,
                      child:
                          Text('Save', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          AlarmTime tmp = AlarmTime();
                          tmp.days = selected;
                          tmp.time = selectedTime;
                          tmp.active = true;
                          alarmlist[count] = tmp;
                          alarmcount = alarmlist.length;
                        });
                        Navigator.of(context).pop();
                      })
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Colors.white,
          child: Icon(
            Icons.delete,
            size: 20.0,
            color: Theme.of(context).accentColor,
          ),
        ));
  }

  DaySelector daySelector() {
    return DaySelector(
        onChange: (value) {
          print('value is $value');
          if (DaySelector.monday & value == DaySelector.monday) {
            selected[0] = true;
          } else {
            selected[0] = false;
          }
          if (DaySelector.tuesday & value == DaySelector.tuesday) {
            selected[1] = true;
          } else {
            selected[1] = false;
          }
          if (DaySelector.wednesday & value == DaySelector.wednesday) {
            selected[2] = true;
          } else {
            selected[2] = false;
          }
          if (DaySelector.thursday & value == DaySelector.thursday) {
            selected[3] = true;
          } else {
            selected[3] = false;
          }
          if (DaySelector.friday & value == DaySelector.friday) {
            selected[4] = true;
          } else {
            selected[4] = false;
          }
          if (DaySelector.saturday & value == DaySelector.saturday) {
            selected[5] = true;
          } else {
            selected[5] = false;
          }
          if (DaySelector.sunday & value == DaySelector.sunday) {
            selected[6] = true;
          } else {
            selected[6] = false;
          }
        },
        color: Colors.white,
        mode: DaySelector.modeFull);
  }

  subtitleonalarmtile(int count) {
    String days = "";
    for (int i = 0; i < 7; i++) {
      if (alarmlist[count].days[i] == true) {
        days = days + weekday[i] + "  ";
      }
    }
    return Text(
      days,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w200, fontSize: 15),
    );
  }

  String daynow(int daynow) {
    daynow = daynow - 1;
    return weekday[daynow];
  }
}

String timeonalarmtile(TimeOfDay time) {
  int hour = time.hour;
  int min = time.minute;
  return "$hour" + ":" + "$min";
}

TimeOfDay selectedTime;
List<String> weekday = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
