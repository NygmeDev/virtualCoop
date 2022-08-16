import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

class CodigoSeguridadService {
  final prefs = PreferenciasUsuario();

  generarCodigoSeguridad(String idecl) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {
      "prccode": "2155",
      "tkn": prefs.token,
      "idecl": idecl,
    };

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);
    return respuesta;
  }
}
