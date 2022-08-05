import 'model/cities_model.dart';
import 'model/countries_model.dart';
import 'model/population_model.dart';
import 'package:http/http.dart' as http;


Future<Population> getPopulation(String cityName) async {
  try{
    Uri url = Uri.parse(
        'https://countriesnow.space/api/v0.1/countries/population/cities/q/?city=$cityName');

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return populationFromJson(response.body);
    } else {
      return populationErrorFromJson(response.body);
    }
  } catch (e){
    print("Printing Exception: $e");
  }
}

Future<Cities> getCity(String countryName) async {
  var url = Uri.parse('https://countriesnow.space/api/v0.1/countries/cities/q/?country=$countryName');
  final response = await http.get(url);
  return citiesFromJson(response.body);
}


Future<Country> getCountry() async {
  var url = Uri.parse('https://countriesnow.space/api/v0.1/countries');
  final response = await http.get(url);
  return countryFromJson(response.body);
}


