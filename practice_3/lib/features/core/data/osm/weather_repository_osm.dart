import 'package:practice_3/features/core/data/osm/osm_api.dart';
import 'package:practice_3/features/core/domain/entities/search_query.dart';
import 'package:practice_3/features/core/domain/entities/search_response.dart';
import 'package:practice_3/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryOSM implements WeatherRepository {
  final OSMApi _api;

  WeatherRepositoryOSM(this._api);

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
    case 'Clouds':
      return 'Clouds';
    case 'Clear':
      return 'Clear';
    case 'Rain':
      return 'Rain';
    default:
      return 'Other';
  }
}