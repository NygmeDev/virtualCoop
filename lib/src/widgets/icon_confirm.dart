import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconConfirm extends StatelessWidget {
  final bool isConfirm;
  IconConfirm({@required this.isConfirm});

  @override
  Widget build(BuildContext context) {
    
    String icon = isConfirm ? 'check' : 'close';
    
    return AspectRatio(
      aspectRatio:2/2,
      child: Container(
        child: SvgPicture.asset(
          'assets/img/$icon.svg',
        ),
      ),
    );
  }
}