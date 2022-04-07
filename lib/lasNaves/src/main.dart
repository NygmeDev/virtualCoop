import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:virtual_coop/app_config.dart';
import 'package:virtual_coop/src/pages/cambiar_contrasenia_page.dart';
import 'package:virtual_coop/src/pages/clave_virtual_page.dart';
import 'package:virtual_coop/src/pages/crear_usuario_page.dart';
import 'package:virtual_coop/src/pages/home_page.dart';
import 'package:virtual_coop/src/pages/login_page.dart';
import 'package:virtual_coop/src/pages/transferencias_interbancarias_page.dart';
import 'package:virtual_coop/src/pages/transferencias_internas_page.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPref();
  prefs.url = 'http://190.107.74.123:2024';
  prefs.token = '0042LasNaves20210319';

  var configuredApp = AppConfig(
    flavorName: "lasNaves",
    child: MyApp(),
  );
  runApp(configuredApp);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'VirtualCoop',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('es', "ES")
      ],
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'crearCuenta': (BuildContext context) => CrearUsuarioPage(),
        'olvidasteContrasenia': (BuildContext context) =>
            OlvidasteContraseniaPage(),
        'home': (BuildContext context) => HomePage(),
        'claveVirtual': (BuildContext context) => GeneracionClaveVirtualPage(),
        'transferenciaDirecta': (BuildContext context) =>
            TransferenciasInternasPage(),
        'transferenciaInterBancaria': (BuildContext context) =>
            TransferenciasInterBancariasPage(),
      },
      theme: ThemeData(
        primaryColor: Color(0xFF336633),
        accentColor: Color(0xFF448844),
      ),
    );
  }
}
