import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;
  CustomTextButton({
    @required this.onPressed,
    @required this.child,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        widget.onPressed();
      },
      child: widget.child,
    );
  }
}
