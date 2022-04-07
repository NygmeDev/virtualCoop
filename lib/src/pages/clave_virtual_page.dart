import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:virtual_coop/src/bloc/clave_virtual_bloc.dart';

import 'package:virtual_coop/src/utils/colores.dart';

class GeneracionClaveVirtualPage extends StatefulWidget {
  @override
  _GeneracionClaveVirtualPageState createState() =>
      _GeneracionClaveVirtualPageState();
}

class _GeneracionClaveVirtualPageState
    extends State<GeneracionClaveVirtualPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final claveVirtuaBloc = new ClaveVirtualBloc();
  final colores = new Colores();

  TextEditingController newPasswordController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    claveVirtuaBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Cambia tu clave virtual'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child:
                          _crearInputPasswordActual(context, claveVirtuaBloc))),
              SizedBox(
                height: screenSize.height * 0.01,
              ),
              Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        _crearInputNewPassword(
                            context, claveVirtuaBloc, newPasswordController),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        _crearInputRepeatNewPassword(
                            context, claveVirtuaBloc, newPasswordController),
                        SizedBox(
                          height: screenSize.height * 0.1,
                        ),
                        _crearBotonGuardar(context, screenSize, claveVirtuaBloc)
                      ],
                    ),
                  )),
            ]),
          ),
        ));
  }

  Widget _crearInputPasswordActual(
      BuildContext context, ClaveVirtualBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordActualStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  prefixIcon:
                      Icon(Icons.lock, color: Theme.of(context).primaryColor),
                  labelText: 'Contraseña Actual',
                  errorText: snapshot.error),
              obscureText: true,
              onChanged: bloc.changePasswordActual,
              //obscureText: true,
            ),
          );
        });
  }

  _crearInputNewPassword(BuildContext context, ClaveVirtualBloc bloc,
      TextEditingController controller) {
    return StreamBuilder(
        stream: bloc.newPasswordStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  prefixIcon:
                      Icon(Icons.lock, color: Theme.of(context).primaryColor),
                  labelText: 'Nueva Contraseña',
                  errorText: snapshot.error),
              obscureText: true,
              onChanged: bloc.changeNewPassword,
              //obscureText: true,
            ),
          );
        });
  }

  _crearInputRepeatNewPassword(BuildContext context, ClaveVirtualBloc bloc,
      TextEditingController controller) {
    return StreamBuilder(
        stream: bloc.repeatPasswordStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    prefixIcon:
                        Icon(Icons.lock, color: Theme.of(context).primaryColor),
                    labelText: 'Repetir Contraseña',
                    errorText: snapshot.error),
                obscureText: true,
                onChanged: (value) {
                  bloc.changeRepeatNewPassword({
                    "newPassword": controller.text,
                    "repeatPassword": value
                  });
                }
                //obscureText: true,
                ),
          );
        });
  }

  Widget _crearBotonGuardar(
      BuildContext context, Size screenSize, ClaveVirtualBloc bloc) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ButtonTheme(
          minWidth: double.infinity,
          height: screenSize.height * 0.07,
          child: StreamBuilder(
              stream: bloc.formValidStream,
              builder: (context, snapshot) {
                return RaisedButton.icon(
                  onPressed: snapshot.hasData
                      ? () =>
                          _cambiarPassword('La contaseña ha sido modificada')
                      : null,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  icon: Icon(Icons.save),
                  label: Text(
                    'Guardar',
                    style: TextStyle(fontSize: screenSize.width * 0.06),
                  ),
                  shape: StadiumBorder(),
                );
              }),
        ));
  }

  _cambiarPassword(String mensaje) {
    FocusScope.of(context).requestFocus(new FocusNode());
    mostrarSnackbar(mensaje);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(
        mensaje,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(milliseconds: 1500),
      backgroundColor: Theme.of(context).primaryColor,
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
