import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String estado;
  String msg;
  List<Cliente> cliente;

  LoginModel({
    this.estado,
    this.msg,
    this.cliente,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        estado: json["estado"],
        msg: json["msg"],
        cliente: json["estado"] == '000'
            ? List<Cliente>.from(
                json["cliente"].map((x) => Cliente.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "msg": msg,
        "cliente": List<dynamic>.from(cliente.map((x) => x.toJson())),
      };
}

class Cliente {
  String codemp;
  String nomemp;
  String codofi;
  String nomofi;
  String codcli;
  String idecli;
  String apecli;
  String nomcli;
  String dirdom;
  String tlfdom;
  String dirtra;
  String tlftra;
  String tlfcel;
  String direma;
  DateTime fecnac;
  String wwwpsw;
  String ctrest;

  Cliente({
    this.codemp,
    this.nomemp,
    this.codofi,
    this.nomofi,
    this.codcli,
    this.idecli,
    this.apecli,
    this.nomcli,
    this.dirdom,
    this.tlfdom,
    this.dirtra,
    this.tlftra,
    this.tlfcel,
    this.direma,
    this.fecnac,
    this.wwwpsw,
    this.ctrest,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        codemp: json["codemp"],
        nomemp: json["nomemp"],
        codofi: json["codofi"],
        nomofi: json["nomofi"],
        codcli: json["codcli"],
        idecli: json["idecli"],
        apecli: json["apecli"],
        nomcli: json["nomcli"],
        dirdom: json["dirdom"],
        tlfdom: json["tlfdom"],
        dirtra: json["dirtra"],
        tlftra: json["tlftra"],
        tlfcel: json["tlfcel"],
        direma: json["direma"],
        fecnac: DateTime.parse(json["fecnac"]),
        wwwpsw: json["wwwpsw"],
        ctrest: json["ctrest"],
      );

  Map<String, dynamic> toJson() => {
        "codemp": codemp,
        "nomemp": nomemp,
        "codofi": codofi,
        "nomofi": nomofi,
        "codcli": codcli,
        "idecli": idecli,
        "apecli": apecli,
        "nomcli": nomcli,
        "dirdom": dirdom,
        "tlfdom": tlfdom,
        "dirtra": dirtra,
        "tlftra": tlftra,
        "tlfcel": tlfcel,
        "direma": direma,
        "fecnac":
            "${fecnac.year.toString().padLeft(4, '0')}-${fecnac.month.toString().padLeft(2, '0')}-${fecnac.day.toString().padLeft(2, '0')}",
        "wwwpsw": wwwpsw,
        "ctrest": ctrest,
      };
}
