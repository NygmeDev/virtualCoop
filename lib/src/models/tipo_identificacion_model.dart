import 'dart:convert';

TipoIdentificacionModel tipoIdentificacionModelFromJson(String str) =>
    TipoIdentificacionModel.fromJson(json.decode(str));

String tipoIdentificacionModelToJson(TipoIdentificacionModel data) =>
    json.encode(data.toJson());

class TipoIdentificacionModel {
  TipoIdentificacionModel({
    this.estado,
    this.msg,
    this.listado,
  });

  String estado;
  String msg;
  List<Listado> listado;

  factory TipoIdentificacionModel.fromJson(Map<String, dynamic> json) =>
      TipoIdentificacionModel(
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
