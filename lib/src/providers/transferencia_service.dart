import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_coop/src/models/ingresar_transferencia_directa.dart';
import 'package:virtual_coop/src/models/ingresar_transferencia_interbancaria_model.dart';
import 'package:virtual_coop/src/models/validar_saldo_disponible_model.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

class TransferenciaService {
  final prefs = PreferenciasUsuario();

  Future validarSaldoDisponible(
      ValidarSaldoDisponibleModel saldoDisponible) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {
      "prccode": "2350",
      "tkn": prefs.token,
      "idecl": saldoDisponible.idecl,
      "codctad": saldoDisponible.codctad,
      "valtrnf": saldoDisponible.valtrnf,
      "tiptrnf": saldoDisponible.tiptrnf,
    };

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);
    return respuesta;
  }

  Future ingresarTransferenciaDirecta(
      IngresoTransferenciaDirectaModel transferencia) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {
      "prccode": "2355",
      "tkn": prefs.token,
      "idecl": transferencia.idecl,
      "codctad": transferencia.codctad,
      "valtrnf": transferencia.valtrnf,
      "codctac": transferencia.codctac,
      "idemsg": transferencia.idemsg,
      "codseg": transferencia.codseg,
    };

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);
    return respuesta;
  }

  Future ingresarTransferenciaInterBancaria(
      IngresarTransferenciaInterbancariaModel transferencia) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {
      "prccode": "2360",
      "tkn": prefs.token,
      "idecl": transferencia.idecl,
      "codctad": transferencia.codctad,
      "valtrnf": transferencia.valtrnf,
      "codifi": transferencia.codifi,
      "ideclr": transferencia.ideclr,
      "nomclr": transferencia.nomclr,
      "codtcur": transferencia.codtcur,
      "codctac": transferencia.codctac,
      "infopi": transferencia.infopi,
      "idemsg": transferencia.idemsg,
      "codseg": transferencia.codseg,
      "bnfcel": transferencia.bnfcel,
      "bnfema": transferencia.bnfema
    };

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);
    return respuesta;
  }
}
