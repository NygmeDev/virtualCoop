// To parse this JSON data, do
//
//     final estadoEconomicoModel = estadoEconomicoModelFromJson(jsonString);

import 'dart:convert';

EstadoEconomicoModel estadoEconomicoModelFromJson(String str) =>
    EstadoEconomicoModel.fromJson(json.decode(str));

String estadoEconomicoModelToJson(EstadoEconomicoModel data) =>
    json.encode(data.toJson());

class EstadoEconomicoModel {
  EstadoEconomicoModel({
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
    this.cuentas,
    this.inversiones,
    this.creditos,
  });

  String codemp;
  String nomemp;
  String codofi;
  String nomofi;
  String codcli;
  String idecli;
  dynamic apecli;
  String nomcli;
  String dirdom;
  String tlfdom;
  String dirtra;
  String tlftra;
  String tlfcel;
  String direma;
  String fecnac;
  String wwwpsw;
  String ctrest;
  List<Cuenta> cuentas;
  List<Inversione> inversiones;
  List<Credito> creditos;

  factory EstadoEconomicoModel.fromJson(Map<String, dynamic> json) =>
      EstadoEconomicoModel(
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
        fecnac: json["fecnac"],
        wwwpsw: json["wwwpsw"],
        ctrest: json["ctrest"],
        cuentas:
            List<Cuenta>.from(json["cuentas"].map((x) => Cuenta.fromJson(x))),
        inversiones: List<Inversione>.from(
            json["inversiones"].map((x) => Inversione.fromJson(x))),
        creditos: List<Credito>.from(
            json["creditos"].map((x) => Credito.fromJson(x))),
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
        "fecnac": fecnac,
        "wwwpsw": wwwpsw,
        "ctrest": ctrest,
        "cuentas": List<dynamic>.from(cuentas.map((x) => x.toJson())),
        "inversiones": List<dynamic>.from(inversiones.map((x) => x.toJson())),
        "creditos": List<dynamic>.from(creditos.map((x) => x.toJson())),
      };
}

class Credito {
  Credito({
    this.codcrd,
    this.fecvnc,
    this.desecr,
    this.destcr,
    this.mntcap,
    this.salcap,
  });

  String codcrd;
  DateTime fecvnc;
  String desecr;
  String destcr;
  String mntcap;
  String salcap;

  factory Credito.fromJson(Map<String, dynamic> json) => Credito(
        codcrd: json["codcrd"],
        fecvnc: DateTime.parse(json["fecvnc"]),
        desecr: json["desecr"],
        destcr: json["destcr"],
        mntcap: json["mntcap"],
        salcap: json["salcap"],
      );

  Map<String, dynamic> toJson() => {
        "codcrd": codcrd,
        "fecvnc":
            "${fecvnc.year.toString().padLeft(4, '0')}-${fecvnc.month.toString().padLeft(2, '0')}-${fecvnc.day.toString().padLeft(2, '0')}",
        "desecr": desecr,
        "destcr": destcr,
        "mntcap": mntcap,
        "salcap": salcap,
      };
}

class Cuenta {
  Cuenta({
    this.codcta,
    this.desect,
    this.desdep,
    this.salcnt,
    this.saldis,
  });

  String codcta;
  String desect;
  String desdep;
  String salcnt;
  String saldis;

  factory Cuenta.fromJson(Map<String, dynamic> json) => Cuenta(
        codcta: json["codcta"],
        desect: json["desect"],
        desdep: json["desdep"],
        salcnt: json["salcnt"],
        saldis: json["saldis"],
      );

  Map<String, dynamic> toJson() => {
        "codcta": codcta,
        "desect": desect,
        "desdep": desdep,
        "salcnt": salcnt,
        "saldis": saldis,
      };
}

class Inversione {
  Inversione({
    this.codinv,
    this.fecvnc,
    this.desein,
    this.destin,
    this.salcnt,
    this.saldis,
  });

  String codinv;
  DateTime fecvnc;
  String desein;
  String destin;
  String salcnt;
  String saldis;

  factory Inversione.fromJson(Map<String, dynamic> json) => Inversione(
        codinv: json["codinv"],
        fecvnc: DateTime.parse(json["fecvnc"]),
        desein: json["desein"],
        destin: json["destin"],
        salcnt: json["salcnt"],
        saldis: json["saldis"],
      );

  Map<String, dynamic> toJson() => {
        "codinv": codinv,
        "fecvnc":
            "${fecvnc.year.toString().padLeft(4, '0')}-${fecvnc.month.toString().padLeft(2, '0')}-${fecvnc.day.toString().padLeft(2, '0')}",
        "desein": desein,
        "destin": destin,
        "salcnt": salcnt,
        "saldis": saldis,
      };
}
