import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final double height;
  final double width;

  CustomElevatedButton({
    this.child,
    this.onTap,
    this.height,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          stops: [0.05, 1],
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
