import 'dart:convert';

ValidarIngresarUsuarioModel ingresarUsuarioModelFromJson(String str) =>
    ValidarIngresarUsuarioModel.fromJson(json.decode(str));

String ingresarUsuarioModelToJson(ValidarIngresarUsuarioModel data) =>
    json.encode(data.toJson());

class ValidarIngresarUsuarioModel {
  String prccode;
  String tkn;
  String idecl;
  String fecha;
  String usr;

  ValidarIngresarUsuarioModel({
    this.prccode,
    this.tkn,
    this.idecl,
    this.fecha,
    this.usr,
  });

  factory ValidarIngresarUsuarioModel.fromJson(Map<String, dynamic> json) =>
      ValidarIngresarUsuarioModel(
        prccode: json["prccode"],
        tkn: json["tkn"],
        idecl: json["idecl"],
        fecha: json["fecha"],
        usr: json["usr"],
      );

  Map<String, dynamic> toJson() => {
        "prccode": prccode,
        "tkn": tkn,
        "idecl": idecl,
        "fecha": fecha,
        "usr": usr,
      };
}
