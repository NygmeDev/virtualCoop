import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:virtual_coop/src/models/amortizacion_model.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

class AmortizacionService {
  final prefs = PreferenciasUsuario();

  Future<AmortizacionModel> consultarAmortizacionXCredito(
      String idecl, String codcrd) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {
      "prccode": "2220",
      "tkn": prefs.token,
      "idecl": idecl,
      "codcrd": codcrd
    };

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);

    return AmortizacionModel.fromJson(respuesta['cliente']);
  }
}
