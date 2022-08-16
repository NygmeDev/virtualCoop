import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPref() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  //GET y SET cedula
  String get cedula {
    return _prefs.getString('cedula') ?? '';
  }

  set cedula(String value) {
    _prefs.setString('cedula', value);
  }

  //GET y SET nombre
  String get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  //GET Y SET username

  String get username {
    return _prefs.getString('username') ?? '';
  }

  set username(String value) {
    _prefs.setString('username', value);
  }

  //GET Y SET puedeUsarHuella

  bool get puedeUsarHuella {
    return _prefs.getBool('puedeUsarHuella') ?? false;
  }

  set puedeUsarHuella(bool value) {
    _prefs.setBool('puedeUsarHuella', value);
  }

  //GET Y SET puedeUsarFaceId

  bool get puedeUsarFaceId {
    return _prefs.getBool('puedeUsarFaceId') ?? false;
  }

  set puedeUsarFaceId(bool value) {
    _prefs.setBool('puedeUsarFaceId', value);
  }

  //GET Y SET huella

  bool get huella {
    return _prefs.getBool('huella') ?? false;
  }

  set huella(bool value) {
    _prefs.setBool('huella', value);
  }

  // GET Y SET menu

  String get menu {
    return _prefs.getString('menu') ?? '';
  }

  set menu(String value) {
    _prefs.setString('menu', value);
  }

  // GET Y SET hora
  String get hora {
    return _prefs.getString('hora') ?? '';
  }

  set hora(String value) {
    _prefs.setString('hora', value);
  }

  // GET Y SET hora
  String get url {
    return _prefs.getString('url') ?? '';
  }

  set url(String value) {
    _prefs.setString('url', value);
  }

  // GET Y SET hora
  String get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }
}
