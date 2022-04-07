// To parse this JSON data, do
//
//     final ingresarTransferenciaInterbancariaModel = ingresarTransferenciaInterbancariaModelFromJson(jsonString);

import 'dart:convert';

IngresarTransferenciaInterbancariaModel
    ingresarTransferenciaInterbancariaModelFromJson(String str) =>
        IngresarTransferenciaInterbancariaModel.fromJson(json.decode(str));

String ingresarTransferenciaInterbancariaModelToJson(
        IngresarTransferenciaInterbancariaModel data) =>
    json.encode(data.toJson());

class IngresarTransferenciaInterbancariaModel {
  IngresarTransferenciaInterbancariaModel({
    this.idecl,
    this.codctad,
    this.valtrnf,
    this.codifi,
    this.ideclr,
    this.nomclr,
    this.codtcur,
    this.codctac,
    this.infopi,
    this.idemsg,
    this.codseg,
    this.bnfcel,
    this.bnfema,
  });

  String idecl;
  String codctad;
  String valtrnf;
  String codifi;
  String ideclr;
  String nomclr;
  String codtcur;
  String codctac;
  String infopi;
  String idemsg;
  String codseg;
  String bnfcel;
  String bnfema;

  factory IngresarTransferenciaInterbancariaModel.fromJson(
          Map<String, dynamic> json) =>
      IngresarTransferenciaInterbancariaModel(
        idecl: json["idecl"],
        codctad: json["codctad"],
        valtrnf: json["valtrnf"],
        codifi: json["codifi"],
        ideclr: json["ideclr "],
        nomclr: json["nomclr "],
        codtcur: json["codtcur "],
        codctac: json["codctac"],
        infopi: json["infopi"],
        idemsg: json["idemsg"],
        codseg: json["codseg"],
        bnfcel: json["bnfcel"],
        bnfema: json["bnfema"],
      );

  Map<String, dynamic> toJson() => {
        "idecl": idecl,
        "codctad": codctad,
        "valtrnf": valtrnf,
        "codifi": codifi,
        "ideclr ": ideclr,
        "nomclr ": nomclr,
        "codtcur ": codtcur,
        "codctac": codctac,
        "infopi": infopi,
        "idemsg": idemsg,
        "codseg": codseg,
        "bnfcel": bnfcel,
        "bnfema": bnfema
      };
}
