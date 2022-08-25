import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final double letterSpacing;

  const CustomText({
    @required this.text,
    @required this.fontSize,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.textDecoration = TextDecoration.none,
    this.letterSpacing = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      textAlign: this.textAlign,
      textScaleFactor: 1,
      style: TextStyle(
        color: this.color,
        fontSize: this.fontSize,
        fontWeight: this.fontWeight,
        fontFamily: 'Helvetica',
        decoration: this.textDecoration,
        letterSpacing: this.letterSpacing,
      ),
    );
  }
}
