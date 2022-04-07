import 'dart:convert';

CuentasClienteModel cuentasClienteModelFromJson(String str) =>
    CuentasClienteModel.fromJson(json.decode(str));

String cuentasClienteModelToJson(CuentasClienteModel data) =>
    json.encode(data.toJson());

class CuentasClienteModel {
  CuentasClienteModel({
    this.estado,
    this.msg,
    this.cliente,
  });

  String estado;
  String msg;
  Cliente cliente;

  factory CuentasClienteModel.fromJson(Map<String, dynamic> json) =>
      CuentasClienteModel(
        estado: json["estado"],
        msg: json["msg"],
        cliente: Cliente.fromJson(json["cliente"]),
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "msg": msg,
        "cliente": cliente.toJson(),
      };
}

class Cliente {
  Cliente({
    this.nomemp,
    this.nomofi,
    this.codcli,
    this.idecli,
    this.apecli,
    this.nomcli,
    this.cuentas,
  });

  String nomemp;
  String nomofi;
  String codcli;
  String idecli;
  dynamic apecli;
  String nomcli;
  List<Cuenta> cuentas;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        nomemp: json["nomemp"],
        nomofi: json["nomofi"],
        codcli: json["codcli"],
        idecli: json["idecli"],
        apecli: json["apecli"],
        nomcli: json["nomcli"],
        cuentas:
            List<Cuenta>.from(json["cuentas"].map((x) => Cuenta.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nomemp": nomemp,
        "nomofi": nomofi,
        "codcli": codcli,
        "idecli": idecli,
        "apecli": apecli,
        "nomcli": nomcli,
        "cuentas": List<dynamic>.from(cuentas.map((x) => x.toJson())),
      };
}

class Cuenta {
  Cuenta({
    this.codcta,
    this.desect,
    this.desdep,
  });

  String codcta;
  String desect;
  String desdep;

  factory Cuenta.fromJson(Map<String, dynamic> json) => Cuenta(
        codcta: json["codcta"],
        desect: json["desect"],
        desdep: json["desdep"],
      );

  Map<String, dynamic> toJson() => {
        "codcta": codcta,
        "desect": desect,
        "desdep": desdep,
      };
}
