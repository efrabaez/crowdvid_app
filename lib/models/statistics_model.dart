import 'package:intl/intl.dart';

class Statistics {
  final int? placeId;
  final DateTime datetime;
  final int ocupability;

  const Statistics(
      {required this.placeId,
      required this.datetime,
      required this.ocupability});

  @override
  String toString() {
    return '{placeId: $placeId, datetime: $datetime, ocupability: $ocupability}';
  }

  factory Statistics.fromJson(Map<String, dynamic> json) {
    final DateFormat dateFormat = DateFormat('EEE, d MMM yyyy HH:mm:ss');
    return Statistics(
      placeId: json.containsKey('placeId') ? json['placeId'] : 0,
      datetime: json.containsKey('datetime')
          ? dateFormat.parse(json['datetime'])
          : DateTime.now(),
      ocupability: json.containsKey('ocupability') ? json['ocupability'] : '',
    );
  }
}
