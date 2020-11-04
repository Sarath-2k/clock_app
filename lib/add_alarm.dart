import 'package:clock_app/11.dart';
import 'package:day_selector/day_selector.dart';
import 'package:flutter/material.dart';

class AddAlarm extends StatefulWidget {
  AddAlarm({Key key}) : super(key: key);

  _AddAlarmState createState() => _AddAlarmState();
}

class _AddAlarmState extends State<AddAlarm> {
  TimeOfDay _selectedTime;
  ValueChanged<TimeOfDay> selectTime;
  List<bool> selected = [false, false, false, false, false, false, false];

  @override
  void initState() {
    _selectedTime = new TimeOfDay(hour: 12, minute: 30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      _selectedTime.format(context),
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
                    child: DaySelector(
                        onChange: (value) {
                          print('value is $value');
                          if (DaySelector.monday & value ==
                              DaySelector.monday) {
                            selected[0] = true;
                          } else {
                            selected[0] = false;
                          }
                          if (DaySelector.tuesday & value ==
                              DaySelector.tuesday) {
                            selected[1] = true;
                          } else {
                            selected[1] = false;
                          }
                          if (DaySelector.wednesday & value ==
                              DaySelector.wednesday) {
                            selected[2] = true;
                          } else {
                            selected[2] = false;
                          }
                          if (DaySelector.thursday & value ==
                              DaySelector.thursday) {
                            selected[3] = true;
                          } else {
                            selected[3] = false;
                          }
                          if (DaySelector.friday & value ==
                              DaySelector.friday) {
                            selected[4] = true;
                          } else {
                            selected[4] = false;
                          }
                          if (DaySelector.saturday & value ==
                              DaySelector.saturday) {
                            selected[5] = true;
                          } else {
                            selected[5] = false;
                          }
                          if (DaySelector.sunday & value ==
                              DaySelector.sunday) {
                            selected[6] = true;
                          } else {
                            selected[6] = false;
                          }
                        },
                        color: Colors.white,
                        mode: DaySelector.modeFull),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  FlatButton(
                      color: Theme.of(context).accentColor,
                      child:
                          Text('Save', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        alarmlist[alarmcount].days = selected;
                        alarmcount = alarmcount + 1;
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
        await showTimePicker(context: context, initialTime: _selectedTime);
    setState(() {
      _selectedTime = picked;
      alarmlist[alarmcount].time = picked;
    });
  }
}

class Alarmtime {}
