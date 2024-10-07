import 'package:practice_1/features/core/data/debug/weather_repository_debug.dart';
import 'package:practice_1/features/core/data/osm/osm_api.dart';
import 'package:practice_1/features/core/data/osm/weather_repository_osm.dart';
import 'package:practice_1/features/core/data/vc/vc_api.dart';
import 'package:practice_1/features/core/data/vc/weather_repository_vc.dart';
import 'package:practice_1/features/core/presentation/app.dart';

const String version = '0.0.1';
const String urlOSM = 'https://api.openweathermap.org';
const String apiKeyOSM = '75e2e5e3d508df1bc09b82145ce62ddc';
const String urlVC = 'https://weather.visualcrossing.com';
const String apiKeyVC = 'GL3TBMB2J47UUVD5NGR47NRHZ';

void main(List<String> arguments) {
  var app = App(WeatherRepositoryOSM(OSMApi(urlOSM, apiKeyOSM)));
//var app = App(WeatherRepositoryVC(VCApi(urlVC, apiKeyVC)));

  app.run();
}
