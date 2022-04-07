import 'dart:convert';

List<MenuModel> menuModelFromJson(String str) =>
    List<MenuModel>.from(json.decode(str).map((x) => MenuModel.fromJson(x)));

String menuModelToJson(List<MenuModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuModel {
  MenuModel({
    this.id,
    this.texto,
    this.dev,
  });

  int id;
  String texto;
  bool dev;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        id: json["id"],
        texto: json["texto"],
        dev: json["dev"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "texto": texto,
        "dev": dev,
      };
}
