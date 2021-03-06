import 'package:flutter/material.dart';
import 'package:virtual_coop/src/images/logoHorizontal.dart';

class FootterLogo extends StatelessWidget {
  final Color color;
  final double indent;
  final Color backgroundColor;

  FootterLogo({
    this.color = Colors.white,
    this.indent = 0,
    this.backgroundColor = Colors.transparent,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: <Widget>[
          Divider(
            endIndent: indent,
            indent: indent,
            color: color,
            height: 10,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: 11 / 1.5,
              child: LogoHorizontal(
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
