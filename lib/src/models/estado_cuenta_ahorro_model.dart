import 'dart:convert';

EstadoCuentaAhorroModel estadoCuentaAhorroModelFromJson(String str) =>
    EstadoCuentaAhorroModel.fromJson(json.decode(str));

String estadoCuentaAhorroModelToJson(EstadoCuentaAhorroModel data) =>
    json.encode(data.toJson());

class EstadoCuentaAhorroModel {
  EstadoCuentaAhorroModel({
    this.nomemp,
    this.nomofi,
    this.codcli,
    this.idecli,
    this.apecli,
    this.nomcli,
    this.cuenta,
    this.detalle,
  });

  String nomemp;
  String nomofi;
  String codcli;
  String idecli;
  dynamic apecli;
  String nomcli;
  Cuenta cuenta;
  List<Detalle> detalle;

  factory EstadoCuentaAhorroModel.fromJson(Map<String, dynamic> json) =>
      EstadoCuentaAhorroModel(
        nomemp: json["nomemp"],
        nomofi: json["nomofi"],
        codcli: json["codcli"],
        idecli: json["idecli"],
        apecli: json["apecli"],
        nomcli: json["nomcli"],
        cuenta: Cuenta.fromJson(json["cuenta"]),
        detalle:
            List<Detalle>.from(json["detalle"].map((x) => Detalle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nomemp": nomemp,
        "nomofi": nomofi,
        "codcli": codcli,
        "idecli": idecli,
        "apecli": apecli,
        "nomcli": nomcli,
        "cuenta": cuenta.toJson(),
        "detalle": List<dynamic>.from(detalle.map((x) => x.toJson())),
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

class Detalle {
  Detalle({
    this.fectrn,
    this.codcaj,
    this.docnum,
    this.tiptrn,
    this.valcre,
    this.valdeb,
    this.saldos,
  });

  DateTime fectrn;
  String codcaj;
  String docnum;
  String tiptrn;
  String valcre;
  String valdeb;
  String saldos;

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        fectrn: DateTime.parse(json["fectrn"]),
        codcaj: json["codcaj"],
        docnum: json["docnum"],
        tiptrn: json["tiptrn"] == null ? null : json["tiptrn"],
        valcre: json["valcre"],
        valdeb: json["valdeb"],
        saldos: json["saldos"],
      );

  Map<String, dynamic> toJson() => {
        "fectrn":
            "${fectrn.year.toString().padLeft(4, '0')}-${fectrn.month.toString().padLeft(2, '0')}-${fectrn.day.toString().padLeft(2, '0')}",
        "codcaj": codcaj,
        "docnum": docnum,
        "tiptrn": tiptrn == null ? null : tiptrn,
        "valcre": valcre,
        "valdeb": valdeb,
        "saldos": saldos,
      };
}
