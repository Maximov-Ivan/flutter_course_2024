import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_1/features/core/data/vc/models/vc_weather.dart';

class VCApi {
  final String url;
  final String apiKey;

  VCApi(this.url, this.apiKey);

  Future<VCWeather> getWeatherCity(String city) async {
    var response = await http.get(Uri.parse('$url/VisualCrossingWebServices/rest/services/timeline/$city?unitGroup=metric&key=$apiKey&contentType=json'));
    var rJson = jsonDecode(response.body);

    return VCWeather(rJson['currentConditions']['temp'], rJson['currentConditions']['icon']);
  }

  Future<VCWeather> getWeatherCoord(String lat, String lon) async {
    var response = await http.get(Uri.parse('$url/VisualCrossingWebServices/rest/services/timeline/$lat%2C$lon?unitGroup=metric&key=$apiKey&contentType=json'));
    var rJson = jsonDecode(response.body);

    return VCWeather(rJson['currentConditions']['temp'], rJson['currentConditions']['icon']);
  }
}