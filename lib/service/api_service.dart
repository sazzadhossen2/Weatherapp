import 'dart:convert';
import 'package:http/http.dart';
import 'package:weatherapp/constant/constant.dart';
import 'package:weatherapp/model/weather_model.dart';

class ApiService {
  Future<WeatherModel> getWeatherData(String searchText) async {
    try {
      Response response = await get(Uri.parse(Urls.WeatherApi(searchText)));
      if (response.statusCode == 200) {
        print(response.body.toString());
        Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
        return weatherModel;
      } else {
        throw ("No data found");
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
