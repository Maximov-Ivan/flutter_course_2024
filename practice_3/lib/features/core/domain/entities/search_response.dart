class SearchResponse {
  final int temp;
  final String type;
  final String icon;

  const SearchResponse(this.temp, this.type, this.icon);

  @override
  String toString() {
    return 'SearchResponse{temp: $temp, type: $type}';
  }
}
