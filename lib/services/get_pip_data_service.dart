import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'constants.dart' as constants;

Future<int> fetchPipData(String deviceId) async {
  final urlDevices =
      '${constants.pipCustomers}/${constants.pipCustomerId}${constants.pipDevices}/$deviceId/status';
  final url = Uri.https(constants.pipBaseURL, urlDevices);
  final response = await http.get(
    url,
    headers: {"X-Pip-API-Key": constants.pipAPIKey},
  );
  debugPrint(url.toString());
  debugPrint('All Places Response status: ${response.statusCode}');
  debugPrint('All Places Response body: ${response.body}');
  final countGroups =
      json.decode(response.body)['Measurements']['Count Groups'];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //List responseJson = json.decode(response.body)['places'];
    return countGroups.reduce((a, b) => a + b);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}
