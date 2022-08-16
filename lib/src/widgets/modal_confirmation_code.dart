import 'package:flutter/material.dart';
import 'package:virtual_coop/src/providers/codigo_seguridad_service.dart';
import 'package:virtual_coop/src/utils/colores.dart';

class ModalConfirmationCode extends StatefulWidget {
  final String idecl;
  final Function(Map<String, String>) onConfirm;
  ModalConfirmationCode(this.idecl, {this.onConfirm});

  @override
  _ModalConfirmationCodeState createState() => _ModalConfirmationCodeState();
}

class _ModalConfirmationCodeState extends State<ModalConfirmationCode> {
  String idemsg = '';

  final codigoSeguridadService = CodigoSeguridadService();
  final colores = Colores();

  TextEditingController codigoController = new TextEditingController();

  cargarCodigo() async {
    final res =
        await codigoSeguridadService.generarCodigoSeguridad(widget.idecl);
    setState(() {
      idemsg = res['cliente'][0]["idemsg"].toString();
    });
  }

  @override
  void initState() {
    cargarCodigo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: Text(
        'Ingresa tu código de confirmación',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
            fontSize: screenSize.height * 0.022),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Hemos enviado un correo y un sms con tu código de confirmación.\nEl código es válido durante 3 minutos.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: colores.texto2,
                height: 1.3,
                fontFamily: 'Helvetica',
                fontSize: screenSize.height * 0.02),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.15),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: codigoController,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  fontSize: screenSize.height * 0.02,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 0,
          ),
          FlatButton(
            child: Text(
              "Solicitar código nuevamente",
              style: TextStyle(
                color: colores.texto1,
                fontSize: screenSize.height * 0.02,
              ),
            ),
            onPressed: () => cargarCodigo(),
          ),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Cancelar",
            style: TextStyle(
                color: colores.texto2,
                fontSize: screenSize.height * 0.025,
                fontFamily: 'Helvetica',
                letterSpacing: 1),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text("Confirmar",
              style: TextStyle(
                  fontSize: screenSize.height * 0.025,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Helvetica',
                  letterSpacing: 1)),
          onPressed: () {
            if (codigoController.text != '') {
              Map<String, String> map = {
                'idemsg': idemsg,
                'codseg': codigoController.text
              };
              widget.onConfirm(map);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
