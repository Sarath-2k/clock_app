import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

int hour = 0;
int min = 0;
int sec = 0;
bool started = true;
bool stopped = true;
int timefortimer = 0;
String timetodisplay = "";
bool checktimer = true;

class _TimerPageState extends State<TimerPage> {
  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timefortimer = ((hour * 60 * 60) + (min * 60) + sec);
    // debugPrint(timefortimer.toString());
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      setState(() {
        if (timefortimer < 1 || checktimer == false) {
          t.cancel();
          checktimer = true;
          timetodisplay = "";
          started = true;
          stopped = true;
        } else if (timefortimer < 60) {
          timetodisplay = timefortimer.toString();
          timefortimer = timefortimer - 1;
        } else if (timefortimer < 3600) {
          int m = timefortimer ~/ 60;
          int s = timefortimer - (60 * m);
          timetodisplay = m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        } else {
          int h = timefortimer ~/ 3600;
          int t = timefortimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timetodisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checktimer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //numberpicker
          Expanded(
              flex: 6,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "HH",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: NumberPicker.integer(
                              listViewWidth: 60.0,
                              infiniteLoop: true,
                              initialValue: hour,
                              minValue: 0,
                              maxValue: 23,
                              onChanged: (val) {
                                setState(() {
                                  hour = val;
                                });
                              }),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "MM",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: NumberPicker.integer(
                              listViewWidth: 60.0,
                              infiniteLoop: true,
                              initialValue: min,
                              minValue: 00,
                              maxValue: 59,
                              onChanged: (val) {
                                setState(() {
                                  min = val;
                                });
                              }),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "SS",
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: NumberPicker.integer(
                              listViewWidth: 60.0,
                              infiniteLoop: true,
                              initialValue: sec,
                              minValue: 0,
                              maxValue: 59,
                              onChanged: (val) {
                                setState(() {
                                  sec = val;
                                });
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              )),
          //text
          Expanded(
              flex: 1,
              child: Text(
                timetodisplay,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              )),
          //buttons
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: started ? start : null,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    child: Text(
                      "Start",
                      style: TextStyle(color: Color(0xff65D1BA)),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  RaisedButton(
                    onPressed: stopped ? null : stop,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    child: Text(
                      "Stop",
                      style: TextStyle(color: Color(0xff65D1BA)),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
