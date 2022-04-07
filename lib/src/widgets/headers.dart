import 'package:flutter/material.dart';
import 'package:virtual_coop/src/images/iconLogin.dart';
import 'package:virtual_coop/src/utils/colores.dart';

class HeaderLogin extends StatelessWidget {
  final colores = new Colores();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: screenSize.height * 0.32,
          width: double.infinity,
          color: Colors.transparent,
          child: CustomPaint(
            painter: _HeaderWaveGradientPainter(
              Color(0xff00BFFF),
              Color(0xFF187CE1),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0, -0.9),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: screenSize.width * 0.08),
              child: AspectRatio(
                aspectRatio: 8 / 2,
                child: IconLogin(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HeaderWaveGradientPainter extends CustomPainter {
  final Color color1;
  final Color color2;

  _HeaderWaveGradientPainter(this.color1, this.color2);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint();
    //Propiedades
    paint.style = PaintingStyle.fill;
    paint.color = Colors.white;

    final path = new Path();
    //Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.2);
    path.quadraticBezierTo(0, size.height, size.width * 0.5, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    //path.lineTo(size.width, size.height*0.32);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
