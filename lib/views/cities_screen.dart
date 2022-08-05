import 'package:api_calling/views/population_screen.dart';
import 'package:flutter/material.dart';
import '../model/cities_model.dart';
import '../rest_api.dart';
import 'package:http/http.dart' as http;

class CityScreen extends StatefulWidget {

  String countryName;

  CityScreen(this.countryName);

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
      ),
      body: FutureBuilder<Cities>(
        future: getCity(widget.countryName),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PopulationScreen(
                                    snapshot.data.data[index])));
                        getPopulation(snapshot.data.data[index]);
                      },
                      child: ListTile(
                          leading:
                          Text(snapshot.data.data[index])),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            }
            return Center(child: CircularProgressIndicator());
          },
      ),
    );
  }
}
