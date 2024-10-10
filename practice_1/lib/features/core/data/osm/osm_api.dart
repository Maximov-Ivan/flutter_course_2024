import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_1/features/core/data/osm/models/osm_weather.dart';

class OSMApi {
  final String url;
  final String apiKey;

  OSMApi(this.url, this.apiKey);

  Future<OSMWeather> getWeatherCity(String city) async {
    var response = await http.get(Uri.parse('$url/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));
    var rJson = jsonDecode(response.body);

    return OSMWeather(rJson['main']['temp'], rJson['weather'][0]['main']);
  }

  Future<OSMWeather> getWeatherCoord(String lat, String lon) async {
    var response = await http.get(Uri.parse('$url/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));
    var rJson = jsonDecode(response.body);

    return OSMWeather(rJson['main']['temp'], rJson['weather'][0]['main']);
  }
}
