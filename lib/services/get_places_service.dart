import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:crowdvid/models/place_model.dart';
import 'constants.dart' as constants;

Future<List<Place>> fetchPlaces() async {
  List<Place> places = [];
  final url = Uri.https(constants.apiBaseURL, constants.allPlaces);
  debugPrint(url.toString());
  final response = await http.get(url);
  debugPrint('All Places Response status: ${response.statusCode}');
  debugPrint('All Places Response body: ${response.body}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List responseJson = json.decode(response.body)['places'];
    responseJson.map((e) => places.add(Place.fromJson(e))).toList();
    return places;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}
