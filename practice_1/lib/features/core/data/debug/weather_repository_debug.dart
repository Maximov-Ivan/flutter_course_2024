import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/entities/search_response.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';

class WeatherRepositoryDebug implements WeatherRepository {
  @override
  Future<SearchResponse> getWeatherCity(SearchQueryCity query) async {
    return SearchResponse(285, WeatherType.clear);
  }

  @override
  Future<SearchResponse> getWeatherCoord(SearchQueryCoord query) async {
    return SearchResponse(285, WeatherType.clear);
  }
}