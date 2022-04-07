// To parse this JSON data, do
//
//     final contactosModel = contactosModelFromJson(jsonString);

import 'dart:convert';

ContactosModel contactosModelFromJson(String str) =>
    ContactosModel.fromJson(json.decode(str));

String contactosModelToJson(ContactosModel data) => json.encode(data.toJson());

class ContactosModel {
  ContactosModel({
    this.estado,
    this.msg,
    this.beneficiario,
  });

  String estado;
  String msg;
  List<Beneficiario> beneficiario;

  factory ContactosModel.fromJson(Map<String, dynamic> json) => ContactosModel(
        estado: json["estado"],
        msg: json["msg"],
        beneficiario: List<Beneficiario>.from(
            json["beneficiario"].map((x) => Beneficiario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "msg": msg,
        "beneficiario": List<dynamic>.from(beneficiario.map((x) => x.toJson())),
      };
}

class Beneficiario {
  Beneficiario({
    this.codifi,
    this.nomifi,
    this.codtid,
    this.idebnf,
    this.codtcu,
    this.destcu,
    this.codcta,
    this.nombnf,
    this.bnfema,
    this.bnfcel,
  });

  String codifi;
  String nomifi;
  String codtid;
  String idebnf;
  String codtcu;
  String destcu;
  String codcta;
  String nombnf;
  String bnfema;
  String bnfcel;

  factory Beneficiario.fromJson(Map<String, dynamic> json) => Beneficiario(
        codifi: json["codifi"],
        nomifi: json["nomifi"],
        codtid: json["codtid"],
        idebnf: json["idebnf"],
        codtcu: json["codtcu"],
        destcu: json["destcu"],
        codcta: json["codcta"],
        nombnf: json["nombnf"],
        bnfema: json["bnfema"],
        bnfcel: json["bnfcel"],
      );

  Map<String, dynamic> toJson() => {
        "codifi": codifi,
        "nomifi": nomifi,
        "codtid": codtid,
        "idebnf": idebnf,
        "codtcu": codtcu,
        "destcu": destcu,
        "codcta": codcta,
        "nombnf": nombnf,
        "bnfema": bnfema,
        "bnfcel": bnfcel,
      };
}
