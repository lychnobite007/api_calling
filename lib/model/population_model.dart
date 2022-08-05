import 'dart:convert';
import 'package:api_calling/views/population_screen.dart';

import '../rest_api.dart';

bool populationError = false;

Population populationFromJson(String str) =>
    Population.fromJson(json.decode(str));

String populationToJson(Population data) => json.encode(data.toJson());

class Population {
  Population({
    this.error,
    this.msg,
    this.data,
  });

  bool error;
  String msg;
  Data data;

  factory Population.fromJson(Map<String, dynamic> json) =>
      Population(
        error: json["error"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.city,
    this.country,
    this.populationCounts,
  });

  String city;
  String country;
  List<PopulationModelCount> populationCounts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    city: json["city"],
    country: json["country"],
    populationCounts: List<PopulationModelCount>.from(
        json["populationCounts"]
            .map((x) => PopulationModelCount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "country": country,
    "populationCounts":
    List<dynamic>.from(populationCounts.map((x) => x.toJson())),
  };
}

class PopulationModelCount {
  PopulationModelCount({
    this.year,
    this.value,
    this.sex,
    this.reliabilty,
  });

  String year;
  String value;
  String sex;
  String reliabilty;

  factory PopulationModelCount.fromJson(Map<String, dynamic> json) =>
      PopulationModelCount(
        year: json["year"],
        value: json["value"],
        sex: json["sex"],
        reliabilty: json["reliabilty"],
      );

  Map<String, dynamic> toJson() => {
    "year": year,
    "value": value,
    "sex": sex,
    "reliabilty": reliabilty,
  };
}

PopulationError populationErrorFromJson(String str) =>
    PopulationError.fromJson(json.decode(str));

String populationErrorToJson(PopulationError data) =>
    json.encode(data.toJson());

class PopulationError extends Population {
  PopulationError({
    this.error,
    this.msg,
  });

  bool error;
  String msg;

  factory PopulationError.fromJson(Map<String, dynamic> json) =>
      PopulationError(
        error: json["error"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
  };
}

class PopulationViewModel {
  PopulationScreen state;

  PopulationViewModel(this.state);

  Future<Population> populationApi(final String cityName) async {
    print("Ok! The populationApi is working fine till now");
    return await getPopulation(cityName);
  }
}