import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dark_light_mode/theme_model.dart';
import '../model/countries_model.dart';
import '../rest_api.dart';
import 'cities_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[800],
          title: Center(child: Text("Select Country")),
          actions: [
            CupertinoSwitch(
              value: themeNotifier.isDark,
                onChanged: (value) {
                  themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                })
          ],
        ),
        backgroundColor: Colors.indigo[100],
        body: FutureBuilder<Country>(
            future: getCountry(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context, int index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(20),
                        hoverColor: Colors.black,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CityScreen(
                                      snapshot.data.data[index].country)));
                          getCity(snapshot.data.data[index].country);
                        },
                        child: Container(
                          margin: EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.blue, Colors.tealAccent]),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                              child: Text(
                            snapshot.data.data[index].country,
                            style: TextStyle(fontSize: 16),
                          )),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error);
              }
              return Center(child: CircularProgressIndicator());
            }),
      );
    });
  }
}
