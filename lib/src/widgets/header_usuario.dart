import 'package:flutter/material.dart';
import 'package:virtual_coop/src/utils/colores.dart';

class HeaderUsuario extends StatelessWidget {
  final Widget title;
  final Widget subtitle;

  final colores = new Colores();

  HeaderUsuario({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: screenSize.height * 0.28,
          width: double.infinity,
          color: Colors.transparent,
          child: CustomPaint(
            painter: _HeaderWaveBack(context),
          ),
        ),
        Container(
          height: screenSize.height * 0.12,
          width: double.infinity,
          color: Colors.transparent,
          child: CustomPaint(
            painter: _HeaderWave(context),
          ),
        ),
        SafeArea(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: screenSize.height * 0.055,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Align(alignment: Alignment(-0.8, -0.72), child: SafeArea(child: title)),
        Align(
            alignment: Alignment(-0.8, -0.6), child: SafeArea(child: subtitle)),
      ],
    );
  }
}

class _HeaderWave extends CustomPainter {
  final BuildContext context;
  _HeaderWave(this.context);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromCircle(center: Offset(0, 15), radius: 200);

    final gradient = new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).accentColor.withOpacity(0.5),
          Theme.of(context).primaryColor,
        ],
        stops: [
          0.2,
          0.7
        ]);

    final paint = new Paint();

    //Propiedades
    paint.style = PaintingStyle.fill;
    paint.shader = gradient.createShader(rect);
    final path = new Path();
    //Dibujar con el path y el lapiz
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.2, size.height, size.width * 0.35, 0);
    canvas.drawPath(path, paint);
  }
}

class _HeaderWaveBack extends CustomPainter {
  final BuildContext context;
  _HeaderWaveBack(this.context);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromCircle(center: Offset(0, 20), radius: 200);

    final gradient = new LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).accentColor,
          Theme.of(context).primaryColor,
        ],
        stops: [
          0.6,
          0.85
        ]);

    final paint = new Paint();

    //Propiedades
    paint.style = PaintingStyle.fill;
    paint.shader = gradient.createShader(rect);
    final path = new Path();
    //Dibujar con el path y el lapiz
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.56, size.height);
    path.quadraticBezierTo(
        size.width * 0.95, size.height, size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }
}
