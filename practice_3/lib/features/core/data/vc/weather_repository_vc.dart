import 'package:practice_3/features/core/data/vc/vc_api.dart';
import 'package:practice_3/features/core/domain/entities/search_query.dart';
import 'package:practice_3/features/core/domain/entities/search_response.dart';
import 'package:practice_3/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryVC implements WeatherRepository {
  final VCApi _api;

  WeatherRepositoryVC(this._api);

  @override
  Future<SearchResponse> getWeatherCity(SearchQueryCity query) async {
    var response = await _api.getWeatherCity(query.city);
    return SearchResponse(response.temp.toInt(), _weatherType(response.type), response.type);
  }

  @override
  Future<SearchResponse> getWeatherCoord(SearchQueryCoord query) async {
    var response = await _api.getWeatherCoord(query.lat, query.lon);
    return SearchResponse(response.temp.toInt(), _weatherType(response.type), response.type);
  }
}

String _weatherType(String type) {
  switch (type) {
    case 'snow':
      return 'снег';
    case 'snow-showers-day':
      return 'местами снег';
    case 'snow-showers-night':
      return 'местами снег';
    case 'thunder-rain':
      return 'гроза';
    case 'thunder-showers-day':
      return 'местами грозы';
    case 'thunder-showers-night':
      return 'местами грозы';
    case 'rain':
      return 'дождь';
    case 'showers-day':
      return 'ливень';
    case 'showers-night':
      return 'ливень';
    case 'fog':
      return 'туман';
    case 'wind':
      return 'ветренно';
    case 'cloudy':
      return 'облачно';
    case 'partly-cloudy-day':
      return 'облачно с прояснениями';
    case 'partly-cloudy-night':
      return 'облачно с прояснениями';
    case 'clear-day':
      return 'ясно';
    case 'clear-night':
      return 'ясно';
    default:
      return 'ясно?';
  }
}