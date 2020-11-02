// import 'package:flutter/material.dart';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';

// class TimerPage extends StatefulWidget {
//   @override
//   _TimerPageState createState() => _TimerPageState();
// }

// class _TimerPageState extends State<TimerPage> {
//   CountDownController _controller = CountDownController();
//   bool _isPause = false;
//   int timerduration = 100;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Center(
//               child: CircularCountDownTimer(
//             // Countdown duration in Seconds
//             duration: timerduration,

//             // Controller to control (i.e Pause, Resume, Restart) the Countdown
//             controller: _controller,

//             // Width of the Countdown Widget
//             width: MediaQuery.of(context).size.width / 2,

//             // Height of the Countdown Widget
//             height: MediaQuery.of(context).size.height / 2,

//             // Default Color for Countdown Timer
//             color: Theme.of(context).accentColor,

//             // Filling Color for Countdown Timer
//             fillColor: Colors.red,

//             // Background Color for Countdown Widget
//             backgroundColor: null,

//             // Border Thickness of the Countdown Circle
//             strokeWidth: 5.0,

//             // Text Style for Countdown Text
//             textStyle: TextStyle(
//                 fontSize: 22.0,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold),

//             // true for reverse countdown (max to 0), false for forward countdown (0 to max)
//             isReverse: true,

//             // true for reverse animation, false for forward animation
//             isReverseAnimation: false,

//             // Optional [bool] to hide the [Text] in this widget.
//             isTimerTextShown: true,

//             // Function which will execute when the Countdown Ends
//             onComplete: () {
//               // Here, do whatever you want
//               print('Countdown Ended');
//             },
//           )),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   IconButton(
//                       icon: Icon(
//                         Icons.exposure_minus_1,
//                         color: Theme.of(context).accentColor,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           timerduration = timerduration - 60;
//                           _controller.restart();
//                         });
//                       }),
//                   RaisedButton(
//                     onPressed: null,
//                     child: Text(
//                       "Min",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   IconButton(
//                       icon: Icon(
//                         Icons.exposure_plus_1,
//                         color: Theme.of(context).accentColor,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           timerduration = timerduration + 60;
//                           _controller.restart();
//                         });
//                       }),
//                 ],
//               ),
//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   IconButton(
//                       icon: Icon(
//                         Icons.exposure_minus_1,
//                         color: Theme.of(context).accentColor,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           timerduration = timerduration - 1;
//                           _controller.restart();
//                         });
//                       }),
//                   RaisedButton(
//                     onPressed: null,
//                     child: Text(
//                       "Sec",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   IconButton(
//                       icon: Icon(
//                         Icons.exposure_plus_1,
//                         color: Theme.of(context).accentColor,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           timerduration = timerduration + 1;
//                           _controller.restart();
//                         });
//                       }),
//                 ],
//               )
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               FloatingActionButton(
//                   child: Icon(Icons.refresh),
//                   onPressed: () {
//                     _controller.restart();
//                   }),
//               FloatingActionButton(
//                   child: Icon(_isPause ? Icons.play_arrow : Icons.pause),
//                   onPressed: () {
//                     setState(() {
//                       if (_isPause) {
//                         _isPause = false;
//                         _controller.resume();
//                       } else {
//                         _isPause = true;
//                         _controller.pause();
//                       }
//                     });
//                   }),
//               // FloatingActionButton.extended(
//               //     onPressed: () {
//               //       setState(() {
//               //         if (_isPause) {
//               //           _isPause = false;
//               //           _controller.resume();
//               //         } else {
//               //           _isPause = true;
//               //           _controller.pause();
//               //         }
//               //       });
//               //     },
//               //     icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
//               //     label: Text(_isPause ? "Resume" : "Pause")),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
