import 'package:flutter/material.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/service/api_service.dart';
import 'package:weatherapp/ui/Widget/fururelistItem.dart';
import 'package:weatherapp/ui/Widget/hourlyweather.dart';
import 'package:weatherapp/ui/Widget/todaysweather.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiService apiService = ApiService();
  final _texfieldcontrolar = TextEditingController();
  String searchText = "auto:ip";

  _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Search Location"),
            content: TextField(
              controller: _texfieldcontrolar,
              decoration: const InputDecoration(
                hintText: "search city,zip",
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    if (_texfieldcontrolar.text.isEmpty) {
                      return;
                    }

                    Navigator.pop(context, _texfieldcontrolar.text);
                  },
                  child: const Text("Ok")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Flutter weather app"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                _texfieldcontrolar.clear();
                String text = await _showTextInputDialog(context);
                setState(() {
                  searchText = text;
                });
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                searchText = "auto:ip";
                setState(() {});
              },
              icon: const Icon(Icons.my_location)),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getWeatherData(searchText),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;
              return SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TodaysWeather(
                        weatherModel: weatherModel,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Weather by Hour",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 159,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            Hour? hour = weatherModel
                                ?.forecast?.forecastday?[0].hour?[index];
                            return HourlyWeather(
                              hour: hour,
                            );
                          },
                          itemCount: weatherModel
                                  ?.forecast?.forecastday?[0].hour?.length ??
                              0,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Next 7 Days Weather",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          Forecastday? forecastday =
                              weatherModel?.forecast?.forecastday?[index];
                          return FtureListItem(
                            forecastday: forecastday,
                          );
                        },
                        itemCount:
                            weatherModel?.forecast?.forecastday?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "An error has occurred",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
