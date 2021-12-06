import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {



  double staticTime = 1500; //1500sec = 25min
  double time = 0;
  double staticPercent = 0.24; //360/time
  double staticPercentSec = 6;
  bool start = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Transform.rotate(
          angle: -pi/2,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF30475e),
              shape: BoxShape.circle,
            ),
            width: 150,
            height: 150,
              child: CustomPaint(
                painter: ClockPainter(time,staticPercent,staticPercentSec),
              ),

          ),
        ),
        SizedBox(height: 15,),
        TextButton(
          child: Text("START", style: TextStyle(color: Colors.white),),
          style: TextButton.styleFrom(backgroundColor: Color(0xFF3F05454)),
          onLongPress: (){
            setState(() {
              start=false;
              time=0;
            });
          },
          onPressed: () {
            print("start");
            setState(() {
              start=true;
            });
            var timer = Timer.periodic(Duration(seconds: 1), (timer) {
              setState(() {
                if(time >= 0 && start){
                  time++;
                  if(time==staticTime || start==false){
                  time=staticTime;
                  timer.cancel();
                }
                  print(time);
                }
                else if(time==staticTime || start==false){
                  time=staticTime;
                  timer.cancel();
                }



              });
            });

          },
        )
      ],
    );
  }
}




class ClockPainter extends CustomPainter {

  final time;
  final staticPercent;
  final staticPercentSec;


  ClockPainter(this.time, this.staticPercent,
      this.staticPercentSec);

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint();
    fillBrush.color = Colors.cyan;

    var centerBrush = Paint()..color = Colors.white;

    var minuteHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFF05454), Colors.pinkAccent])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var secHandBrush = Paint()
      ..color = Color(0xFFF0C929)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    var minuteHandx = centerX + 45 * cos(time * staticPercent * pi / 180);
    var minuteHandy = centerY + 45 * sin(time * staticPercent * pi / 180);

    var secHandx = centerX + 55 * cos(time * staticPercentSec * pi / 180);
    var secHandy = centerY + 55 * sin(time * staticPercentSec * pi / 180);

    canvas.drawCircle(center, radius - 10, fillBrush);
    canvas.drawLine(center, Offset(minuteHandx, minuteHandy), minuteHandBrush);
    canvas.drawLine(center, Offset(secHandx, secHandy), secHandBrush);
    canvas.drawCircle(center, 13, centerBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; //will repaint when state change
  }
}

