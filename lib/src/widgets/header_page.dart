import 'package:flutter/material.dart';
import 'package:virtual_coop/src/utils/colores.dart';

class HeaderPage extends StatelessWidget {
  final String titulo;
  final colores = new Colores();
  HeaderPage(this.titulo);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            height: screenSize.height * 0.006,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.03,
                vertical: screenSize.height * 0.015),
            child: Text(
              titulo,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Helvetica',
                  fontSize: screenSize.height * 0.025,
                  fontWeight: FontWeight.w600),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
          ),
          SizedBox(
            height: screenSize.height * 0.02,
          )
        ],
      ),
    );
  }
}
