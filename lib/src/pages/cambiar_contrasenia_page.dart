import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtual_coop/src/models/validar_ingresar_usuario_model.dart';
import 'package:virtual_coop/src/widgets/header_usuario.dart';

class OlvidasteContraseniaPage extends StatefulWidget {
  @override
  _OlvidasteContraseniaPageState createState() =>
      _OlvidasteContraseniaPageState();
}

class _OlvidasteContraseniaPageState extends State<OlvidasteContraseniaPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool cargando = false;
  bool _obscureTextNewPassword = true;
  bool _obscureTextRepeatPassword = true;

  TextEditingController _identificacionController = new TextEditingController();
  TextEditingController _fechaNacimientoController =
      new TextEditingController();
  TextEditingController _nombreUsuarioController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _repeatPasswordController = new TextEditingController();

  ValidarIngresarUsuarioModel ingresarUsuario =
      new ValidarIngresarUsuarioModel();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          _body(context, screenSize),
          HeaderUsuario(
            title: Text(
              '¿Olvidaste tu contraseña?',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: screenSize.height * 0.035,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, Size screenSize) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Container(
        height: screenSize.height,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: screenSize.height * 0.27,
            ),
            _crearInputIdentificacion(screenSize),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            _crearInputFechaNacimiento(screenSize),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            _crearInputUserName(screenSize),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            _crearNewPassword(screenSize),
            SizedBox(
              height: screenSize.height * 0.02,
            ),
            _crearRepeatPassword(screenSize),
            Spacer(),
            _crearBotonRegistrarUsuario(context, screenSize),
            Spacer()
          ],
        ),
      ),
    ));
  }

  Widget _crearInputIdentificacion(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: _identificacionController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Cédula, RUC o Pasaporte",
          labelStyle: TextStyle(fontSize: screenSize.height * 0.02),
        ),
        onSaved: (value) => ingresarUsuario.idecl = value,
        validator: (value) {
          if (value == '') {
            return 'Ingrese una identificacion';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _crearInputFechaNacimiento(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: _fechaNacimientoController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Fecha de Nacimiento',
          labelStyle: TextStyle(fontSize: screenSize.height * 0.02),
        ),
        onSaved: (value) => ingresarUsuario.fecha = value,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
        validator: (value) {
          if (value == '') {
            return 'Ingrese su fecha de nacimiento';
          } else {
            return null;
          }
        },
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      final _fecha = '${picked.year}-${picked.month}-${picked.day}';
      setState(() {
        _fechaNacimientoController.text = _fecha;
      });
    }
  }

  Widget _crearInputUserName(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: _nombreUsuarioController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: 'Ingrese un nombre de usuario',
          labelStyle: TextStyle(fontSize: screenSize.height * 0.02),
        ),
        onSaved: (value) => ingresarUsuario.usr = value,
        validator: (value) {
          if (value == '') {
            return 'Ingrese un nombre de usuario';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _crearNewPassword(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: _newPasswordController,
        keyboardType: TextInputType.text,
        obscureText: _obscureTextNewPassword,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  _obscureTextNewPassword = false;
                });
                Timer(
                    Duration(milliseconds: 2000),
                    () => setState(() {
                          _obscureTextNewPassword = true;
                        }));
              }),
          labelText: 'Contraseña',
          labelStyle: TextStyle(fontSize: screenSize.height * 0.02),
        ),
        validator: (value) {
          if (value.length < 4) {
            return 'La contraseña debe tener mas de 4 caracteres';
          } else if (value == '') {
            return 'Ingrese una contraseña';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _crearRepeatPassword(Size screenSize) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: _repeatPasswordController,
        keyboardType: TextInputType.text,
        obscureText: _obscureTextRepeatPassword,
        decoration: InputDecoration(
          labelText: 'Confirmar Contraseña',
          labelStyle: TextStyle(fontSize: screenSize.height * 0.02),
        ),
        validator: (value) {
          if (value != _newPasswordController.text || value == '') {
            return 'La contraseña no coincide con la ingresada anteriormente';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _crearBotonRegistrarUsuario(BuildContext context, Size screenSize) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.25),
        child: Container(
          height: screenSize.height * 0.07,
          child: RaisedButton(
            onPressed: null,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            splashColor: Theme.of(context).primaryColor,
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Theme.of(context).accentColor,
                        Theme.of(context).primaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      stops: [0.05, 1]),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 300.0,
                  minHeight: screenSize.height * 0.07,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Registrar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenSize.height * 0.025,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ));
  }

  /*_registrarUsuario(){
    if(!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        //return ModalConfirmationCode();
      }
    );

  }*/
}
