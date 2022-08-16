import 'dart:async';

import 'package:flutter/material.dart';
import 'package:virtual_coop/src/images/logoHorizontal.dart';

import 'package:virtual_coop/src/pages/saldos_economicos_page.dart';
import 'package:virtual_coop/src/pages/transferencias_interbancarias_page.dart';
import 'package:virtual_coop/src/pages/transferencias_internas_page.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';
import 'package:virtual_coop/src/utils/colores.dart';
import 'package:virtual_coop/src/widgets/drawer_virtualcoop.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final colores = new Colores();
  final prefs = PreferenciasUsuario();
  int pantalla = 0;

  seleccionarPantalla() {
    switch (pantalla) {
      case 0:
        return SaldosEconomicosPage();
      case 1:
        return TransferenciasInternasPage();
      case 2:
        return TransferenciasInterBancariasPage();
      default:
        return SaldosEconomicosPage();
    }
  }

  @override
  void initState() {
    super.initState();
    // Add the observer.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (DateTime.now().difference(DateTime.parse(prefs.hora)).inMinutes >=
            5) {
          Timer(Duration(seconds: 1), () {
            prefs.huella = true;
            Navigator.pushReplacementNamed(context, 'login');
          });
        }
        break;
      case AppLifecycleState.inactive:
        prefs.hora = DateTime.now().toString();
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _appBar(screenSize),
      body: seleccionarPantalla(),
      backgroundColor: colores.fondo,
      drawer: DrawerVirtualCoop(
        onTapItem: (value) {
          setState(() {
            pantalla = value;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _appBar(Size screenSize) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: new IconThemeData(color: Theme.of(context).primaryColor),
      elevation: 0,
      title: Row(
        children: <Widget>[
          Container(
            width: screenSize.width * 0.4,
            child: LogoHorizontal(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              if ((prefs.puedeUsarHuella || prefs.puedeUsarFaceId) &&
                  !prefs.huella) {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(prefs.puedeUsarHuella
                              ? 'Acceso con Huella'
                              : 'Acceso con FaceId'),
                          content: Text(
                              '¿Quieres ingresar con tu ${prefs.puedeUsarHuella ? 'huella' : 'FaceId'}?'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  prefs.huella = true;
                                  Navigator.pushReplacementNamed(
                                    context,
                                    'login',
                                  );
                                },
                                child: Text("Si")),
                            FlatButton(
                                onPressed: () {
                                  prefs.username = '';
                                  prefs.huella = false;
                                  prefs.cedula = '';
                                  prefs.nombre = '';
                                  Navigator.pushReplacementNamed(
                                    context,
                                    'login',
                                  );
                                },
                                child: Text("No")),
                          ],
                        ));
              } else {
                Navigator.pushReplacementNamed(context, 'login');
              }
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
