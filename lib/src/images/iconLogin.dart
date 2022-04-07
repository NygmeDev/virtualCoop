import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:virtual_coop/src/images/pathSelector.dart';
import '../../app_config.dart';

class IconLogin extends StatelessWidget {
  final String flavor;
  const IconLogin({this.flavor = "", key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    var pathImg = pathSelector(config == null ? flavor : config.flavorName);

    return Container(
      child: SvgPicture.asset(
        '$pathImg/iconLogin.svg',
      ),
    );
  }
}
