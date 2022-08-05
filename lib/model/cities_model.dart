import 'dart:convert';

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));

String citiesToJson(Cities data) => json.encode(data.toJson());

class Cities {
  Cities({
    this.error,
    this.msg,
    this.data,
  });

  bool error;
  String msg;
  List<String> data;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
    error: json["error"],
    msg: json["msg"],
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
