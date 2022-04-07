import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_coop/src/utils/colores.dart';
import 'package:virtual_coop/src/utils/utils.dart';

class ModalPassword extends StatefulWidget {
  final Function(String) getPassword;

  ModalPassword({@required this.getPassword});

  @override
  _ModalPasswordState createState() => _ModalPasswordState();
}

class _ModalPasswordState extends State<ModalPassword> {
  final List<String> abecedario = shuffleAbecedario();

  final List<String> numeros = shuffleNumeros();

  final TextEditingController _passwordController = new TextEditingController();
  bool obscure = true;
  bool upperCase = false;
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    final colores = new Colores();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        width: maxWidth,
        height: maxHeight * 0.85,
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: _crearInputPassword(context, maxHeight)),
                ],
              ),
              SizedBox(
                height: maxHeight * 0.03,
              ),
              _crearAbecedario(context, maxHeight, colores.texto3, upperCase),
              Divider(),
              _crearNumericos(context, maxHeight, colores.texto3, upperCase),
              Divider(),
              RaisedButton(
                padding: EdgeInsets.symmetric(
                    horizontal: maxWidth * 0.1, vertical: maxHeight * 0.015),
                shape: StadiumBorder(),
                color: Theme.of(context).accentColor,
                child: Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(
                      fontSize: maxHeight * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Helvetica'),
                ),
                onPressed: comprobarContrasenia(_passwordController.text)
                    ? () {
                        Navigator.pop(context);
                        widget.getPassword(_passwordController.text);
                      }
                    : null,
              ),
              //_olvidasteTuContrasenia(colores.texto3, maxHeight)
            ],
          ),
        ),
      ),
    );
  }

  Widget boton(BuildContext context, double height, String valor, Color color,
      bool uppercase) {
    return Container(
      height: height * 0.055,
      width: height * 0.055,
      child: Center(
        child: RaisedButton(
          color: color,
          textColor: Colors.white,
          onPressed: () {
            if (isNumeric(valor)) {
              _passwordController.text += valor;
            } else {
              _passwordController.text +=
                  uppercase ? valor.toUpperCase() : valor.toLowerCase();
            }
            setState(() {});
          },
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            uppercase ? valor.toUpperCase() : valor.toLowerCase(),
            style: TextStyle(
              fontSize: height * 0.03,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget botonUppercase(BuildContext context, double height, Color color) {
    return Container(
      height: height * 0.055,
      width: height * 0.055,
      child: Center(
        child: RaisedButton(
            color: color,
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                upperCase = !upperCase;
              });
            },
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Icon(Icons.arrow_upward)),
      ),
    );
  }

  Widget _olvidasteTuContrasenia(Color color, double maxHeight) {
    return FlatButton(
      onPressed: () {},
      child: Text(
        'Olvidaste tu contraseña',
        style: TextStyle(
            fontSize: maxHeight * 0.02,
            fontWeight: FontWeight.bold,
            color: color,
            fontFamily: 'Helvetica'),
      ),
    );
  }

  Widget _crearAbecedario(
      BuildContext context, double maxHeight, Color color, bool uppercase) {
    final List<Widget> opciones = [];

    abecedario.forEach((letra) {
      final widget = boton(context, maxHeight, letra, color, uppercase);
      opciones.add(widget);
    });

    opciones..add(botonUppercase(context, maxHeight, color));

    return Wrap(
      direction: Axis.horizontal,
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: opciones,
    );
  }

  Widget _crearNumericos(
      BuildContext context, double maxHeight, Color color, bool uppercase) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.start,
      children: numeros
          .map((numero) => boton(context, maxHeight, numero, color, uppercase))
          .toList()
          .cast<Widget>(),
    );
  }

  Widget _crearInputPassword(BuildContext context, double maxHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Acceso con Contraseña',
            ),
            readOnly: true,
            obscureText: obscure,
          ),
          SizedBox(
            height: maxHeight * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTapDown: (e) {
                  setState(() {
                    obscure = false;
                  });
                },
                onTapUp: (e) {
                  setState(() {
                    obscure = true;
                  });
                },
                child: Icon(FontAwesomeIcons.eye),
              ),
              GestureDetector(
                onTap: () {
                  var lenght = _passwordController.text.length;
                  _passwordController.text =
                      _passwordController.text.substring(0, lenght - 1);
                  setState(() {});
                },
                child: Icon(FontAwesomeIcons.arrowLeft),
              ),
            ],
          )
        ],
      ),
    );
  }
}
