import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_coop/src/models/contactos_model.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

class ContactoService {
  final prefs = PreferenciasUsuario();

  Future consultarContactos(String idecl, bool isTransferenciaDirecta) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {
      "tkn": prefs.token,
      "prccode": isTransferenciaDirecta ? 2325 : 2330,
      "idecl": idecl,
    };

    final res = await http.post(url, body: json.encode(body));

    return contactosModelFromJson(res.body);
  }
}
