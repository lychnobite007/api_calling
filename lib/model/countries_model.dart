import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    this.error,
    this.msg,
    this.data,
  });

  bool error;
  String msg;
  List<Datum> data;

  factory Country.fromJson(Map<String, dynamic> json) =>
      Country(
        error: json["error"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

}

class Datum {
  Datum({
  this.iso2,
  this.iso3,
  this.country,
  this.cities,
  });

  String iso2;
  String iso3;
  String country;
  List<String> cities;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
  iso2: json["iso2"],
  iso3: json["iso3"],
  country: json["country"],
  cities: List<String>.from(json["cities"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
  "iso2": iso2,
  "iso3": iso3,
  "country": country,
  "cities": List<dynamic>.from(cities.map((x) => x)),
  };
  }