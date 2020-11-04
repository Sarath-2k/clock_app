import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchPage extends StatefulWidget {
  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    onChange: (value) {},
    onChangeRawSecond: (value) {},
    onChangeRawMinute: (value) {},
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _stopWatchTimer.rawTime.listen((value) {});
    _stopWatchTimer.minuteTime.listen((value) {});
    _stopWatchTimer.secondTime.listen((value) {});
    _stopWatchTimer.records.listen((value) {});
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /// Display stop watch time
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.value,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime =
                      StopWatchTimer.getDisplayTime(value, hours: _isHours);
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          displayTime,
                          style: const TextStyle(
                              color: Color(0xff65D1BA),
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            /// Display every minute.
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.minuteTime,
                initialData: _stopWatchTimer.minuteTime.value,
                builder: (context, snap) {
                  // final value = snap.data;
                  return Column(
                    children: <Widget>[],
                  );
                },
              ),
            ),

            /// Display every second.
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: StreamBuilder<int>(
                stream: _stopWatchTimer.secondTime,
                initialData: _stopWatchTimer.secondTime.value,
                builder: (context, snap) {
                  // final value = snap.data;
                  return Column(
                    children: <Widget>[],
                  );
                },
              ),
            ),

            /// Lap time.
            Container(
              height: 120,
              margin: const EdgeInsets.all(8),
              child: StreamBuilder<List<StopWatchRecord>>(
                stream: _stopWatchTimer.records,
                initialData: _stopWatchTimer.records.value,
                builder: (context, snap) {
                  final value = snap.data;
                  if (value.isEmpty) {
                    return Container();
                  }
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut);
                  });
                  return ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final data = value[index];
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              '${index + 1} ${data.displayTime}',
                              style: const TextStyle(
                                  color: Color(0xff65D1BA),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            height: 1,
                          )
                        ],
                      );
                    },
                    itemCount: value.length,
                  );
                },
              ),
            ),

            /// Button
            Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RaisedButton(
                            padding: const EdgeInsets.all(4),
                            color: Colors.white,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.start);
                            },
                            child: const Text(
                              'Start',
                              style: TextStyle(color: Color(0xff65D1BA)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RaisedButton(
                            padding: const EdgeInsets.all(4),
                            color: Colors.white,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.stop);
                            },
                            child: const Text(
                              'Stop',
                              style: TextStyle(color: Color(0xff65D1BA)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RaisedButton(
                            padding: const EdgeInsets.all(4),
                            color: Colors.white,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.reset);
                            },
                            child: const Text(
                              'Reset',
                              style: TextStyle(color: Color(0xff65D1BA)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0).copyWith(right: 8),
                          child: RaisedButton(
                            padding: const EdgeInsets.all(4),
                            color: Colors.white,
                            shape: const StadiumBorder(),
                            onPressed: () async {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.lap);
                            },
                            child: const Text(
                              'Lap',
                              style: TextStyle(color: Color(0xff65D1BA)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
