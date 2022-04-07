import 'dart:convert';

TipoInstitucionFinancieraModel tipoInstitucionFinancieraModelFromJson(
        String str) =>
    TipoInstitucionFinancieraModel.fromJson(json.decode(str));

String tipoInstitucionFinancieraModelToJson(
        TipoInstitucionFinancieraModel data) =>
    json.encode(data.toJson());

class TipoInstitucionFinancieraModel {
  TipoInstitucionFinancieraModel({
    this.estado,
    this.msg,
    this.listado,
  });

  String estado;
  String msg;
  List<Listado> listado;

  factory TipoInstitucionFinancieraModel.fromJson(Map<String, dynamic> json) =>
      TipoInstitucionFinancieraModel(
        estado: json["estado"],
        msg: json["msg"],
        listado:
            List<Listado>.from(json["listado"].map((x) => Listado.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "msg": msg,
        "listado": List<dynamic>.from(listado.map((x) => x.toJson())),
      };
}

class Listado {
  Listado({
    this.codigo,
    this.descri,
  });

  String codigo;
  String descri;

  factory Listado.fromJson(Map<String, dynamic> json) => Listado(
        codigo: json["codigo"],
        descri: json["descri"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "descri": descri,
      };
}
