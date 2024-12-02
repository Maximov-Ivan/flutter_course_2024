import 'package:flutter/material.dart';
import 'package:practice_3/features/core/data/debug/weather_repository_debug.dart';
import 'package:practice_3/features/core/data/osm/osm_api.dart';
import 'package:practice_3/features/core/data/osm/weather_repository_osm.dart';
import 'package:practice_3/features/core/data/vc/vc_api.dart';
import 'package:practice_3/features/core/data/vc/weather_repository_vc.dart';
import 'package:practice_3/features/core/domain/entities/search_query.dart';
import 'package:practice_3/features/core/domain/entities/search_response.dart';
import 'keys.dart';

const String version = '0.0.1';
const String urlVC = 'https://weather.visualcrossing.com';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IDMeteo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'IDMeteo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  var repository = WeatherRepositoryVC(VCApi(urlVC, apiKeyVC));
  late SearchResponse _resp;
  bool _isInAsyncCall = false;
  bool _showInfo = false;
  late String _city;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitQuery(String city) async{
    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Пожалуйста, введите город'),
            duration: Duration(milliseconds: 1500)
        ),
      );
      return;
    }
    setState(() {
      _isInAsyncCall = true;
      _showInfo = false;
      _city = city;
    });
    try {
      await Future.delayed(const Duration(seconds: 1));
      _resp = await repository.getWeatherCity(SearchQueryCity(city));
    } on Exception {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Не удается найти город $city :('),
          duration: const Duration(milliseconds: 1500)
        ),
      );
      return;
    } finally {
      setState(() {
        _isInAsyncCall = false;
      });
    }
    setState(() {
      _showInfo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                onSubmitted: _submitQuery,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'enter a city name, e.g. Moscow',
                  filled: true,
                ),
              ),
            ),
            if(_isInAsyncCall)
              const SizedBox(
                height: 300,
                width: 300,
                child: Center(
                    child: CircularProgressIndicator()
                ),
              ),
            if(_showInfo)
              Padding(
                padding: const EdgeInsets.all(40),
                child: Center(
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      border: Border.all(
                        width: 4,
                        color: Colors.amber.shade300,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Погода в городе $_city:', style: const TextStyle(fontSize: 25.0)),
                        Text(_resp.type, style: const TextStyle(fontSize: 25.0)),
                        Text('Температура: ${_resp.temp}°C', style: const TextStyle(fontSize: 25.0)),
                        Image.network('https://raw.githubusercontent.com/visualcrossing/WeatherIcons/refs/heads/main/PNG/2nd Set - Color/${_resp.icon}.png'),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
