import 'package:practice_1/features/core/domain/entities/search_query.dart';
import 'package:practice_1/features/core/domain/repositories/weather_repository.dart';
import 'dart:io';

class App {
  final WeatherRepository repository;

  App(this.repository);

  void run() async {
    print('Выберите тип запроса:\n  city - по городу\n  coord - по координатам');
    var mode = stdin.readLineSync();

    if (mode == 'city') {
      print('Введите город:');
      var city = stdin.readLineSync();

      if (city == null) {
        print('Ошибка ввода');
        return;
      }

      var resp = await repository.getWeatherCity(SearchQueryCity(city));

      print('Погода в городе $city: ${resp.temp} по Цельсию, тип: ${resp.type}');
    }

    else if (mode == 'coord') {
      print('Введите широту');
      var lat = stdin.readLineSync();

      if (lat == null) {
        print('Ошибка ввода');
        return;
      }

      print('Введите долготу');
      var lon = stdin.readLineSync();

      if (lon == null) {
        print('Ошибка ввода');
        return;
      }

      var resp = await repository.getWeatherCoord(SearchQueryCoord(lat, lon));

      print('Погода по координатам $lat $lon: ${resp.temp} по Цельсию, тип: ${resp.type}');
    }
  }
}