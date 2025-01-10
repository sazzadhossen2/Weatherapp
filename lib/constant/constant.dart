
class Urls {
  static const String base_url="http://api.weatherapi.com/v1/forecast.json?key=0ca0909e9a61426194d164654251001";
 static String  WeatherApi(String searchText) => "$base_url&q=$searchText&days=7";
}
