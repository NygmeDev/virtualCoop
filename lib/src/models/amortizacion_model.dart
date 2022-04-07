import 'dart:convert';

AmortizacionModel amortizacionModelFromJson(String str) =>
    AmortizacionModel.fromJson(json.decode(str));

String amortizacionModelToJson(AmortizacionModel data) =>
    json.encode(data.toJson());

class AmortizacionModel {
  AmortizacionModel({
    this.nomemp,
    this.nomofi,
    this.codcli,
    this.idecli,
    this.apecli,
    this.nomcli,
    this.credito,
    this.cuotas,
  });

  String nomemp;
  String nomofi;
  String codcli;
  String idecli;
  dynamic apecli;
  String nomcli;
  Credito credito;
  List<Cuota> cuotas;

  factory AmortizacionModel.fromJson(Map<String, dynamic> json) =>
      AmortizacionModel(
        nomemp: json["nomemp"],
        nomofi: json["nomofi"],
        codcli: json["codcli"],
        idecli: json["idecli"],
        apecli: json["apecli"],
        nomcli: json["nomcli"],
        credito: Credito.fromJson(json["credito"]),
        cuotas: List<Cuota>.from(json["cuotas"].map((x) => Cuota.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nomemp": nomemp,
        "nomofi": nomofi,
        "codcli": codcli,
        "idecli": idecli,
        "apecli": apecli,
        "nomcli": nomcli,
        "credito": credito.toJson(),
        "cuotas": List<dynamic>.from(cuotas.map((x) => x.toJson())),
      };
}

class Credito {
  Credito({
    this.codcrd,
    this.fecini,
    this.fecvnc,
    this.desecr,
    this.destcr,
    this.desprd,
    this.tascrd,
    this.mntcap,
    this.salcap,
  });

  String codcrd;
  DateTime fecini;
  DateTime fecvnc;
  String desecr;
  String destcr;
  String desprd;
  String tascrd;
  String mntcap;
  String salcap;

  factory Credito.fromJson(Map<String, dynamic> json) => Credito(
        codcrd: json["codcrd"],
        fecini: DateTime.parse(json["fecini"]),
        fecvnc: DateTime.parse(json["fecvnc"]),
        desecr: json["desecr"],
        destcr: json["destcr"],
        desprd: json["desprd"],
        tascrd: json["tascrd"],
        mntcap: json["mntcap"],
        salcap: json["salcap"],
      );

  Map<String, dynamic> toJson() => {
        "codcrd": codcrd,
        "fecini":
            "${fecini.year.toString().padLeft(4, '0')}-${fecini.month.toString().padLeft(2, '0')}-${fecini.day.toString().padLeft(2, '0')}",
        "fecvnc":
            "${fecvnc.year.toString().padLeft(4, '0')}-${fecvnc.month.toString().padLeft(2, '0')}-${fecvnc.day.toString().padLeft(2, '0')}",
        "desecr": desecr,
        "destcr": destcr,
        "desprd": desprd,
        "tascrd": tascrd,
        "mntcap": mntcap,
        "salcap": salcap,
      };
}

class Cuota {
  Cuota({
    this.numcuo,
    this.fecini,
    this.fecvnc,
    this.valcap,
    this.valint,
    this.valotr,
    this.valcuo,
    this.salcuo,
    this.estcuo,
  });

  String numcuo;
  DateTime fecini;
  DateTime fecvnc;
  String valcap;
  String valint;
  String valotr;
  String valcuo;
  String salcuo;
  String estcuo;

  factory Cuota.fromJson(Map<String, dynamic> json) => Cuota(
        numcuo: json["numcuo"],
        fecini: DateTime.parse(json["fecini"]),
        fecvnc: DateTime.parse(json["fecvnc"]),
        valcap: json["valcap"],
        valint: json["valint"],
        valotr: json["valotr"],
        valcuo: json["valcuo"],
        salcuo: json["salcuo"],
        estcuo: json["estcuo"],
      );

  Map<String, dynamic> toJson() => {
        "numcuo": numcuo,
        "fecini":
            "${fecini.year.toString().padLeft(4, '0')}-${fecini.month.toString().padLeft(2, '0')}-${fecini.day.toString().padLeft(2, '0')}",
        "fecvnc":
            "${fecvnc.year.toString().padLeft(4, '0')}-${fecvnc.month.toString().padLeft(2, '0')}-${fecvnc.day.toString().padLeft(2, '0')}",
        "valcap": valcap,
        "valint": valint,
        "valotr": valotr,
        "valcuo": valcuo,
        "salcuo": salcuo,
        "estcuo": estcuo,
      };
}
