class Place {
  final int placeId;
  final String name;

  const Place({
    required this.placeId,
    required this.name,
  });

  @override
  String toString() {
    return '{placeId: $placeId, name: $name}';
  }

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json.containsKey('placeId') ? json['placeId'] : 0,
      name: json.containsKey('name') ? json['name'] : '',
    );
  }
}
