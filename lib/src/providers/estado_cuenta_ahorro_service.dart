import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_coop/src/models/estado_cuenta_ahorro_model.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

class EstadoCuentaAhorrosService {
  final prefs = PreferenciasUsuario();

  Future<EstadoCuentaAhorroModel> consultarEstadoCuentaAhorro(
      String idecl, String codcta) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {
      "prccode": "2210",
      "tkn": prefs.token,
      "idecl": idecl,
      "codcta": codcta
    };

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);

    return EstadoCuentaAhorroModel.fromJson(respuesta['cliente']);
  }
}
