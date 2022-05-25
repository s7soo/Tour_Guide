import 'package:flutter/material.dart';
import 'package:tour_guide/General_Page/components/constants.dart';
class DecorativeContainer extends StatelessWidget {
  DecorativeContainer({required this.widget,this.color=boxColor,this.height=100,this.width=400});
  final widget;
  final color;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg2.png'),
              fit: BoxFit.fill,
            ),
            color: Colors.white,
            // border: Border.all(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0),
            )
          ],
    ),
    width: width,
    height: height,
    child: widget
    );
  }
}
