import 'package:flutter/material.dart';
import '../model/population_model.dart';
import 'package:http/http.dart' as http;


class PopulationScreen extends StatelessWidget {
  final String cityName;

  PopulationScreen(this.cityName);

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


  @override
  Widget build(BuildContext context) {
    PopulationViewModel model = PopulationViewModel(this);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$cityName",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: FutureBuilder<Population>(
            future: model.populationApi(cityName),
            builder: (BuildContext context,
                AsyncSnapshot<Population> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(snapshot
                          .data.data.populationCounts[index].year),
                      title: Text(snapshot
                          .data.data.populationCounts[index].value),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount:
                  snapshot.data.data.populationCounts.length,
                );
              }
              return null;
            }
            ),
        ),
      ),
    );
  }
}