import 'dart:convert';

IngresoTransferenciaDirectaModel ingresoTransferenciaDirectaModelFromJson(
        String str) =>
    IngresoTransferenciaDirectaModel.fromJson(json.decode(str));

String ingresoTransferenciaDirectaModelToJson(
        IngresoTransferenciaDirectaModel data) =>
    json.encode(data.toJson());

class IngresoTransferenciaDirectaModel {
  IngresoTransferenciaDirectaModel({
    this.idecl,
    this.codctad,
    this.valtrnf,
    this.codctac,
    this.idemsg,
    this.codseg,
  });

  String idecl;
  String codctad;
  String valtrnf;
  String codctac;
  String idemsg;
  String codseg;

  factory IngresoTransferenciaDirectaModel.fromJson(
          Map<String, dynamic> json) =>
      IngresoTransferenciaDirectaModel(
        idecl: json["idecl"],
        codctad: json["codctad"],
        valtrnf: json["valtrnf"],
        codctac: json["codctac"],
        idemsg: json["idemsg"],
        codseg: json["codseg"],
      );

  Map<String, dynamic> toJson() => {
        "idecl": idecl,
        "codctad": codctad,
        "valtrnf": valtrnf,
        "codctac": codctac,
        "idemsg": idemsg,
        "codseg": codseg,
      };
}
