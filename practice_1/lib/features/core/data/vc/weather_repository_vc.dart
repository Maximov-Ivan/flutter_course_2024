import 'package:practice_1/features/core/data/vc/vc_api.dart';
import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryVC implements WeatherRepository {
  final VCApi _api;

  WeatherRepositoryVC(this._api);

  @override
  Future<SearchResponse> getWeatherCity(SearchQueryCity query) async {
    var response = await _api.getWeatherCity(query.city);
    return SearchResponse(response.temp.toInt(), _weatherType(response.type));
  }

  @override
  Future<SearchResponse> getWeatherCoord(SearchQueryCoord query) async {
    var response = await _api.getWeatherCoord(query.lat, query.lon);
    return SearchResponse(response.temp.toInt(), _weatherType(response.type));
  }
}

WeatherType _weatherType(String type) {
  switch (type) {
    case 'cloudy':
      return WeatherType.cloudy;
    case 'clear-day':
      return WeatherType.clear;
    case 'clear-night':
      return WeatherType.clear;
    case 'rain':
      return WeatherType.rain;
    default:
      return WeatherType.other;
  }
}