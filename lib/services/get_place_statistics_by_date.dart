import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:crowdvid/models/statistics_model.dart';
import 'constants.dart' as constants;

Future<List<Statistics>> fetchPlaceStatisticsByDate(
    int placeId, String date) async {
  List<Statistics> places = [];
  final url = Uri.https(constants.apiBaseURL, constants.placeStatisticsByDate);
  debugPrint(url.toString());
  final body =
      json.encode({'place_id': placeId < 4 ? placeId : 3, 'date': date});
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  debugPrint('Body: ${body.toString()}');
  debugPrint('All Places Response status: ${response.statusCode}');
  //debugPrint('All Places Response body: ${response.body}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List responseJson = json.decode(response.body)['statistics'];
    responseJson.map((e) => places.add(Statistics.fromJson(e))).toList();
    return places;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}
