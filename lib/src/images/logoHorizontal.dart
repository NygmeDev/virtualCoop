import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_coop/src/images/pathSelector.dart';
import '../../app_config.dart';

class LogoHorizontal extends StatelessWidget {
  final Color color;
  LogoHorizontal({this.color, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    var pathImg = pathSelector(config.flavorName);
    return Container(
      child: SvgPicture.asset(
        '$pathImg/logo_horizontal.svg',
        color: this.color,
      ),
    );
  }
}
