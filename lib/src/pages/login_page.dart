import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';

import 'package:virtual_coop/src/providers/login_service.dart';
import 'package:virtual_coop/src/providers/menu_provider.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';
import 'package:virtual_coop/src/utils/colores.dart';
import 'package:virtual_coop/src/utils/utils.dart' as utils;
import 'package:virtual_coop/src/widgets/fotter_logo.dart';
import 'package:virtual_coop/src/widgets/headers.dart';
import 'package:virtual_coop/src/widgets/icon_confirm.dart';
import 'package:virtual_coop/src/widgets/modalPassword.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final prefs = PreferenciasUsuario();
  final LocalAuthentication auth = LocalAuthentication();

  bool cargando = false;
  bool userName = false;
  bool userNameValidate = false;

  TextEditingController _userNameController = new TextEditingController();

  Future<void> _authorizeNow() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Ponga su dedo en el sensor para ingresar',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    if (authenticated) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {}
  }

  _obtenerListaBiometricos() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (Platform.isIOS) {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        // Touch ID.
      }
    } else if (Platform.isAndroid) {
      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        prefs.puedeUsarHuella = true;
      }
    }
  }

  bool _validarNombreUsuario() {
    if (utils.comprobarLetrasNumeros(_userNameController.text)) {
      setState(() {
        userName = true;
        userNameValidate = true;
      });
      return true;
    } else {
      setState(() {
        userName = true;
        userNameValidate = false;
      });
      return false;
    }
  }

  @override
  void initState() {
    _obtenerListaBiometricos();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          _body(context, screenSize, scaffoldKey),
          HeaderLogin(),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, Size screenSize,
      GlobalKey<ScaffoldState> scaffoldKey) {
    return SingleChildScrollView(
      child: Container(
          height: screenSize.height,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              SizedBox(height: screenSize.height * 0.32),
              _mensajeBienvenida(context, screenSize),
              SizedBox(
                height: screenSize.height * 0.012,
              ),
              !prefs.huella
                  ? _crearInputCedula(context, screenSize, userNameValidate)
                  : _nombreUsuario(screenSize),
              Spacer(),
              _elijaOpcionDeIngreso(screenSize),
              SizedBox(
                height: screenSize.height * 0.012,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  prefs.huella
                      ? _ingresoHuella(screenSize, prefs.puedeUsarHuella)
                      : SizedBox(),
                  SizedBox(
                    width: prefs.cedula != '' ? screenSize.width * 0.04 : 0,
                  ),
                  _ingresoContrasenia(screenSize)
                ],
              ),
              Spacer(
                flex: 2,
              ),
              cargando
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : SizedBox(),
              Spacer(),
              _crearFlatButtonCrearUsuario(context, screenSize),
              FootterLogo(
                indent: screenSize.width * 0.1,
              )
            ],
          )),
    );
  }

  Widget _mensajeBienvenida(BuildContext context, Size screenSize) {
    final colorMensaje = Colors.white;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              'Bienvenido',
              style: TextStyle(
                  color: colorMensaje,
                  fontSize: screenSize.height * 0.055,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Helvetica'),
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              'Inicia sesión en tu cuenta',
              style: TextStyle(
                  color: colorMensaje,
                  fontSize: screenSize.width * 0.048,
                  fontFamily: 'Helvetica'),
            ),
          )
        ],
      ),
    );
  }

  Widget _crearInputCedula(
      BuildContext context, Size screenSize, bool userNameValidate) {
    final colores = Colores();
    return Container(
        margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: screenSize.height * 0.06,
              padding: EdgeInsets.symmetric(
                horizontal: 5.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: TextField(
                controller: _userNameController,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Nombre de Usuario',
                  hintStyle: TextStyle(
                      fontSize: screenSize.height * 0.025,
                      color: colores.texto3,
                      fontFamily: 'Helvetica'),
                  border: InputBorder.none,
                  suffixIcon: !userName
                      ? SizedBox()
                      : userNameValidate
                          ? IconConfirm(isConfirm: true)
                          : IconConfirm(isConfirm: false),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _crearFlatButtonCrearUsuario(BuildContext context, Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, 'crearCuenta');
        },
        child: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.white, fontFamily: 'Helvetica'),
                children: [
              TextSpan(
                  text: '¿No tienes un usuario?',
                  style: TextStyle(fontSize: screenSize.height * 0.022)),
              TextSpan(
                  text: ' Crea un Usuario',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.height * 0.025)),
            ])),
        textColor: Theme.of(context).accentColor,
      ),
    );
  }

  Widget _elijaOpcionDeIngreso(Size screenSize) {
    return Container(
      child: Text(
        'Elija opcion de ingreso',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: screenSize.height * 0.023,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Helvetica'),
      ),
    );
  }

  Widget _ingresoHuella(Size screenSize, bool mostrar) {
    return mostrar
        ? InkWell(
            onTap: _authorizeNow,
            child: Container(
              height: screenSize.height * 0.1,
              width: screenSize.height * 0.12,
              child: AspectRatio(
                aspectRatio: 9 / 2,
                child: Container(
                  child: SvgPicture.asset(
                    'assets/img/huella.svg',
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _ingresoContrasenia(Size screenSize) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        Timer(Duration(milliseconds: 500), () {
          if (prefs.huella) {
            _userNameController.text = prefs.username;
          }
          if (_validarNombreUsuario()) {
            showDialog(
              context: context,
              builder: (_) => ModalPassword(
                getPassword: (value) {
                  setState(() {
                    cargando = true;
                  });
                  if (value != '' || value.isNotEmpty) {
                    _login(context, _userNameController.text, value);
                  } else {
                    mostrarSnackbar('Su información es incorrecta', Colors.red,
                        scaffoldKey);
                  }
                },
              ),
            );
          } else {
            mostrarSnackbar('Ingrese un Usuario', Colors.red, scaffoldKey);
          }
        });
      },
      child: Container(
        height: screenSize.height * 0.1,
        width: screenSize.height * 0.12,
        child: AspectRatio(
          aspectRatio: 9 / 2,
          child: Container(
            child: SvgPicture.asset(
              'assets/img/icon_password.svg',
            ),
          ),
        ),
      ),
    );
  }

  Widget _nombreUsuario(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            prefs.nombre,
            style: TextStyle(
                fontSize: screenSize.height * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Helvetica'),
          ),
          FlatButton(
            onPressed: () {
              prefs.username = '';
              prefs.huella = false;
              prefs.cedula = '';
              prefs.nombre = '';
              _userNameController.text = '';
              setState(() {});
            },
            child: Text(
              '¿No eres tú?',
              style: TextStyle(
                  fontSize: screenSize.height * 0.022,
                  color: Colors.white,
                  fontFamily: 'Helvetica',
                  decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  _login(BuildContext context, String userName, String password) async {
    final loginModel = await LoginService().login(userName, password);
    if (loginModel.estado == '000') {
      prefs.cedula = loginModel.cliente[0].idecli;
      prefs.nombre = loginModel.cliente[0].nomcli;
      prefs.username = userName;

      prefs.menu = await menuProvider.cargarMenuService();
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      setState(() {
        cargando = false;
      });
      mostrarSnackbar('Su información es incorrecta', Colors.red, scaffoldKey);
    }
  }

  void mostrarSnackbar(
      String mensaje, Color colorAlert, GlobalKey<ScaffoldState> scaffoldKey) {
    final snackbar = SnackBar(
        content: Text(
          mensaje,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(milliseconds: 1500),
        backgroundColor: colorAlert);

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
