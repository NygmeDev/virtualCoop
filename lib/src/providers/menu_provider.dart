import 'package:http/http.dart' as http;
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';
import 'dart:convert';

class _MenuProvider {
  final prefs = PreferenciasUsuario();

  List<dynamic> opciones = [];
  String contacto = '';

  Future<String> cargarMenuService() async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';

    final body = {"prccode": "0100", "tkn": prefs.token};

    final res = await http.post(url, body: json.encode(body));
    return res.body;
  }
}

final menuProvider = new _MenuProvider();
