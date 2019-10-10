import 'package:flutter/material.dart';

class BackgroundCircle extends StatelessWidget {
  var height,width;
  Color color;
  
  BackgroundCircle(this.height,this.width,this.color
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}