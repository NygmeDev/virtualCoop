// To parse this JSON data, do
//
//     final registrarUsuarioModel = registrarUsuarioModelFromJson(jsonString);

import 'dart:convert';

RegistrarUsuarioModel registrarUsuarioModelFromJson(String str) =>
    RegistrarUsuarioModel.fromJson(json.decode(str));

String registrarUsuarioModelToJson(RegistrarUsuarioModel data) =>
    json.encode(data.toJson());

class RegistrarUsuarioModel {
  RegistrarUsuarioModel({
    this.idecl,
    this.usr,
    this.pwd,
    this.idemsg,
    this.codseg,
  });

  String idecl;
  String usr;
  String pwd;
  String idemsg;
  String codseg;

  factory RegistrarUsuarioModel.fromJson(Map<String, dynamic> json) =>
      RegistrarUsuarioModel(
        idecl: json["idecl"],
        usr: json["usr"],
        pwd: json["pwd"],
        idemsg: json["idemsg"],
        codseg: json["codseg"],
      );

  Map<String, dynamic> toJson() => {
        "idecl": idecl,
        "usr": usr,
        "pwd": pwd,
        "idemsg": idemsg,
        "codseg": codseg,
      };
}
