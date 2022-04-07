import 'dart:convert';

ValidarSaldoDisponibleModel validarSaldoDisponibleModelFromJson(String str) =>
    ValidarSaldoDisponibleModel.fromJson(json.decode(str));

String validarSaldoDisponibleModelToJson(ValidarSaldoDisponibleModel data) =>
    json.encode(data.toJson());

class ValidarSaldoDisponibleModel {
  ValidarSaldoDisponibleModel({
    this.idecl,
    this.codctad,
    this.valtrnf,
    this.tiptrnf,
  });

  String idecl;
  String codctad;
  String valtrnf;
  String tiptrnf;

  factory ValidarSaldoDisponibleModel.fromJson(Map<String, dynamic> json) =>
      ValidarSaldoDisponibleModel(
        idecl: json["idecl"],
        codctad: json["codctad"],
        valtrnf: json["valtrnf"],
        tiptrnf: json["tiptrnf"],
      );

  Map<String, dynamic> toJson() => {
        "idecl": idecl,
        "codctad": codctad,
        "valtrnf": valtrnf,
        "tiptrnf": tiptrnf,
      };
}
