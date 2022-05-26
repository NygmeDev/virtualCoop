import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_coop/src/models/registrar_usuario_model.dart';
import 'package:virtual_coop/src/models/validar_ingresar_usuario_model.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

class UsuarioService {
  final prefs = PreferenciasUsuario();

  validacionRegistroUsuario(ValidarIngresarUsuarioModel usuario) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {
      "prccode": "2150",
      "tkn": prefs.token,
      "idecl": usuario.idecl,
      "fecna": usuario.fecha,
      "usr": usuario.usr
    };

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);

    return respuesta;
  }

  registrarUsuario(RegistrarUsuarioModel usuario) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {
      "prccode": "2160",
      "tkn": prefs.token,
      "idecl": usuario.idecl,
      "usr": usuario.usr,
      "pwd": usuario.pwd,
      "idemsg": usuario.idemsg,
      "codseg": usuario.codseg
    };

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);

    return respuesta;
  }
}
