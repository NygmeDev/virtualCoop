import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:virtual_coop/src/models/login_model.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

class LoginService {
  final prefs = PreferenciasUsuario();

  Future<LoginModel> login(String username, String password) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';

    final body = {
      "prccode": "2100",
      "tkn": prefs.token,
      "usr": username,
      "pwd": password
    };

    final res = await http.post(url, body: json.encode(body));

    return loginModelFromJson(res.body);
  }
}
