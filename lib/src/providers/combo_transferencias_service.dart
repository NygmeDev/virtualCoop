import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:virtual_coop/src/models/cuenta_cliente_model.dart';
import 'package:virtual_coop/src/models/tipo_cuenta_model.dart';
import 'package:virtual_coop/src/models/tipo_identificacion_model.dart';
import 'package:virtual_coop/src/models/tipo_institucion_financiera_model.dart';
import 'package:virtual_coop/src/shared_prefs/preferencias_usuario.dart';

class ComboTransaccionesClienteService {
  final prefs = PreferenciasUsuario();

  Future<CuentasClienteModel> consultarCuentasDisponibleCliente(
      String idecl) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {"prccode": "2300", "tkn": prefs.token, "idecl": idecl};
    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);

    return CuentasClienteModel.fromJson(respuesta);
  }

  Future<CuentasClienteModel> consultarCuentasDisponibleTerceros(
      String idecl) async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {"prccode": "2300", "tkn": prefs.token, "idecl": idecl};

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);

    CuentasClienteModel cuenta = new CuentasClienteModel();

    if (respuesta['estado'] != '000') {
      cuenta.estado = respuesta['estado'];
      cuenta.cliente = new Cliente();
      cuenta.cliente.cuentas = [];
    } else if (respuesta['estado'] == '000') {
      cuenta = CuentasClienteModel.fromJson(respuesta);
    }

    return cuenta;
  }

  Future<TipoIdentificacionModel> consultarTiposIdentificacion() async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {"prccode": "2315", "tkn": prefs.token};

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);

    return TipoIdentificacionModel.fromJson(respuesta);
  }

  Future<TipoCuentaModel> consultarTiposCuenta() async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {"prccode": "2320", "tkn": prefs.token};

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);

    return TipoCuentaModel.fromJson(respuesta);
  }

  Future<TipoInstitucionFinancieraModel>
      consultarTipoInstitucionFinanciera() async {
    final url = '${prefs.url}/wsVirtualCoopSrv/ws_server/prctrans.php';
    final body = {"prccode": "2310", "tkn": prefs.token};

    final res = await http.post(url, body: json.encode(body));
    final respuesta = json.decode(res.body);

    return TipoInstitucionFinancieraModel.fromJson(respuesta);
  }
}
