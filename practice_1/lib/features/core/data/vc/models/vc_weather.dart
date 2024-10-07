class VCWeather {
  final double temp;
  final String type;

  const VCWeather(this.temp, this.type);

  @override
  String toString() {
    return 'OSMWeather{temp: $temp, type: $type}';
  }
}