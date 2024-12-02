import 'package:practice_3/features/core/domain/entities/search_query.dart';
import 'package:practice_3/features/core/domain/entities/search_response.dart';

abstract class WeatherRepository {
  Future<SearchResponse> getWeatherCity(SearchQueryCity query);
  Future<SearchResponse> getWeatherCoord(SearchQueryCoord query);
}