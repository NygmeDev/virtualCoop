import 'package:flutter/material.dart';

import 'package:virtual_coop/src/models/registrar_usuario_model.dart';
import 'package:virtual_coop/src/models/validar_ingresar_usuario_model.dart';
import 'package:virtual_coop/src/providers/usuario_service.dart';
import 'package:virtual_coop/src/utils/colores.dart';
import 'package:virtual_coop/src/utils/utils.dart';
import 'package:virtual_coop/src/widgets/dropdown_virtualcoop.dart';
import 'package:virtual_coop/src/widgets/fotter_logo.dart';
import 'package:virtual_coop/src/widgets/header_usuario.dart';
import 'package:virtual_coop/src/widgets/modal_confirmation_code.dart';
import 'package:virtual_coop/src/widgets/mostrar_snackbar.dart';
import 'package:virtual_coop/src/widgets/text_field_virtual_coop.dart';

class CrearUsuarioPage extends StatefulWidget {
  @override
  _CrearUsuarioPageState createState() => _CrearUsuarioPageState();
}

class _CrearUsuarioPageState extends State<CrearUsuarioPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final usuarioService = new UsuarioService();
  final colores = new Colores();

  bool cargando = false;

  bool identificacion = false;
  bool identificacionValidate = false;

  int tipoIdentificacion = 0;

  TextEditingController _identificacionController = new TextEditingController();
  TextEditingController _fechaNacimientoController =
      new TextEditingController();
  TextEditingController _nombreUsuarioController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _repeatPasswordController = new TextEditingController();

  GlobalKey<FormFieldState> keyTipoIdentificacion =
      new GlobalKey<FormFieldState>();

  ValidarIngresarUsuarioModel ingresarUsuario =
      new ValidarIngresarUsuarioModel();

  bool seleccionarTipoValidacionIdentificacion(String value) {
    switch (tipoIdentificacion) {
      case 0:
        return comprobarCedula(value);
      case 1:
        return comprobarCorreo(value);
      case 2:
        return comprobarCedula(value);
      default:
        return false;
    }
  }

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
              'Crear Usuario',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: screenSize.height * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Helvetica'),
            ),
            subtitle: Text(
              'Ingresa los datos Solicitados',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenSize.height * 0.022,
                fontFamily: 'Helvetica',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, Size screenSize) {
    final sizeBox = screenSize.height * 0.06;
    final sizeFont = screenSize.height * 0.022;
    final colorFondoInput = colores.fondo.withOpacity(0.4);
    final colorTexto = colores.texto3;

    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: screenSize.height * 0.31,
                    ),
                    _title('Seleccione tipo de Identificación', screenSize),
                    SizedBox(
                      height: screenSize.height * 0.018,
                    ),
                    DropDownVirtualCoop(
                      llave: keyTipoIdentificacion,
                      sizeBox: sizeBox,
                      sizeFont: sizeFont,
                      colorFondo: colorFondoInput,
                      colorTexto: colorTexto,
                      indexResponse: true,
                      items: ['Cédula', 'RUC', 'Pasaporte'],
                      hint: 'Cédula / RUC / Pasaporte',
                      onChanged: (value) {
                        setState(() {
                          tipoIdentificacion = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: screenSize.height * 0.018,
                    ),
                    _crearInputIdentificacion(
                        sizeBox, sizeFont, colorFondoInput, colorTexto),
                    SizedBox(
                      height: screenSize.height * 0.028,
                    ),
                    _title('Fecha de Nacimiento', screenSize),
                    SizedBox(
                      height: screenSize.height * 0.018,
                    ),
                    _crearInputFechaNacimiento(
                        sizeBox, sizeFont, colorFondoInput, colorTexto),
                    SizedBox(
                      height: screenSize.height * 0.028,
                    ),
                    _title('Nombre de Usuario', screenSize),
                    SizedBox(
                      height: screenSize.height * 0.018,
                    ),
                    _crearInputUserName(
                        sizeBox, sizeFont, colorFondoInput, colorTexto),
                    SizedBox(
                      height: screenSize.height * 0.018,
                    ),
                    _crearNewPassword(
                        sizeBox, sizeFont, colorFondoInput, colorTexto),
                    SizedBox(
                      height: screenSize.height * 0.018,
                    ),
                    _crearRepeatPassword(
                        sizeBox, sizeFont, colorFondoInput, colorTexto),
                    SizedBox(
                      height: screenSize.height * 0.018,
                    ),
                    _crearBotonRegistrarUsuario(context, screenSize),
                  ],
                ),
              ),
            ),
          )),
        ),
        FootterLogo(
          color: null,
          indent: screenSize.width * 0.1,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget _title(String title, Size screenSize) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
            color: colores.texto2,
            fontSize: screenSize.height * 0.025,
            fontFamily: 'Helvetica'),
      ),
    );
  }

  Widget _crearInputIdentificacion(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
        sizeBox: sizeBox,
        sizeFont: sizeFont,
        colorFondo: colorFondoInput,
        colorTexto: colorTexto,
        keyboardType: TextInputType.number,
        hintText: 'Ingrese número de Identificación',
        controller: _identificacionController,
        onSaved: (value) => ingresarUsuario.idecl = value,
        validator: seleccionarTipoValidacionIdentificacion);
  }

  Widget _crearInputFechaNacimiento(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Color(0xffffc529),
        textSelectionColor: Colors.white,
        colorScheme: ColorScheme(
          background: Colors.red,
          brightness: Brightness.light,
          error: Colors.red,
          onBackground: Theme.of(context).primaryColor,
          onError: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          primary: Theme.of(context).primaryColor,
          primaryVariant: Colors.white,
          secondary: Theme.of(context).primaryColor,
          secondaryVariant: Theme.of(context).primaryColor,
          surface: Theme.of(context).primaryColor,
        ),
      ),
      child: Builder(
        builder: (context) => TextFieldVirtualCoop(
          sizeBox: sizeBox,
          sizeFont: sizeFont,
          colorFondo: colorFondoInput,
          colorTexto: colorTexto,
          hintText: 'Fecha de Nacimiento',
          controller: _fechaNacimientoController,
          onSaved: (value) => ingresarUsuario.fecha = value,
          validator: comprobarCampoNoVacio,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _selectDate(context);
          },
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1950),
        lastDate: new DateTime(DateTime.now().year + 1),
        locale: Locale('es', 'ES'));

    if (picked != null) {
      final _mes = picked.month < 10 ? '0${picked.month}' : '${picked.month}';
      final _dia = picked.day < 10 ? '0${picked.day}' : '${picked.day}';
      final _fecha = '$_mes/$_dia/${picked.year}';
      setState(() {
        _fechaNacimientoController.text = _fecha;
      });
    }
  }

  Widget _crearInputUserName(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
        sizeBox: sizeBox,
        sizeFont: sizeFont,
        colorFondo: colorFondoInput,
        colorTexto: colorTexto,
        hintText: 'Ingrese un Nombre',
        controller: _nombreUsuarioController,
        onSaved: (value) => ingresarUsuario.usr = value,
        validator: comprobarCampoNoVacio);
  }

  Widget _crearNewPassword(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorFondo: colorFondoInput,
      colorTexto: colorTexto,
      hintText: 'Contraseña',
      obscureText: true,
      controller: _newPasswordController,
      //onSaved: (value) => ingresarUsuario.idecl = value,
      validator: (value) {
        if (value.length < 4) {
          return false;
        } else if (value == '') {
          return false;
        } else {
          return true;
        }
      },
    );
  }

  Widget _crearRepeatPassword(double sizeBox, double sizeFont,
      Color colorFondoInput, Color colorTexto) {
    return TextFieldVirtualCoop(
      sizeBox: sizeBox,
      sizeFont: sizeFont,
      colorFondo: colorFondoInput,
      colorTexto: colorTexto,
      hintText: 'Confirmar Contraseña',
      obscureText: true,
      controller: _repeatPasswordController,
      validator: (value) {
        if (value != _newPasswordController.text || value == '') {
          return false;
        } else {
          return true;
        }
      },
    );
  }

  Widget _crearBotonRegistrarUsuario(BuildContext context, Size screenSize) {
    return Container(
      height: screenSize.height * 0.06,
      child: RaisedButton(
        onPressed: _registrarUsuario,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
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
              "Registrarse ahora",
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.0,
                  fontSize: screenSize.height * 0.035,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  _registrarUsuario() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    final res = await usuarioService.validacionRegistroUsuario(ingresarUsuario);

    if (res['estado'] == '000') {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return ModalConfirmationCode(
              ingresarUsuario.idecl,
              onConfirm: (value) async {
                RegistrarUsuarioModel registrarUsuarioModel =
                    new RegistrarUsuarioModel();
                registrarUsuarioModel.idecl = ingresarUsuario.idecl;
                registrarUsuarioModel.pwd = _newPasswordController.text;
                registrarUsuarioModel.usr = ingresarUsuario.usr;
                registrarUsuarioModel.idemsg = value['idemsg'];
                registrarUsuarioModel.codseg = value['codseg'];

                final resRegistrar = await usuarioService
                    .registrarUsuario(registrarUsuarioModel);

                if (resRegistrar['estado'] == '000') {
                  mostrarSnackbar('Usuario Ingresado Correctamente',
                      Colors.green, _scaffoldKey);
                } else {
                  mostrarSnackbar(res['msg'], Colors.red, _scaffoldKey);
                }
              },
            );
          });
    } else {
      mostrarSnackbar(res['msg'], Colors.red, _scaffoldKey);
    }
  }
}
