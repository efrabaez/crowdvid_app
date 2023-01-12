import 'dart:async';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crowdvid/models/statistics_model.dart';
import 'constants.dart' as constants;

Future<List<Statistics>> fetchPlacePredictionStatistics(
    int placeId, DateTime selectedDate) async {
  List<Statistics> stats = [];
  String endpoint = '';
  switch (placeId) {
    case 1:
      endpoint = constants.schoolEntrancePrediction;
      break;
    case 2:
      endpoint = constants.govtDataPrediction;
      break;
    default:
      endpoint = constants.sinteticDataPrediction;
      break;
  }
  final url = Uri.https(constants.forecastURL, endpoint);
  debugPrint(url.toString());
  final response = await http.get(url);
  final List<String> data = response.body.split("\n");
  for (int i = 1; i < data.length - 1; i++) {
    List<String> statistic = data[i].split(",");
    DateTime dateTime = DateTime.parse(statistic[1]);
    num ocupability = double.parse(statistic.last);
    debugPrint('$dateTime | $selectedDate');
    if (DateUtils.isSameDay(dateTime, selectedDate)) {
      stats.add(
        Statistics(
          placeId: 1,
          datetime: dateTime,
          ocupability: ocupability > 0 ? ocupability : 0,
        ),
      );
    }
  }
  //debugPrint('Prediction Service: ${stats}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return stats;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}
