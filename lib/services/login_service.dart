import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:crowdvid/models/user_model.dart';
import 'constants.dart' as constants;

Future<User> fetchUser(String email, String password) async {
  final url = Uri.https(constants.apiBaseURL, constants.userLogin);
  debugPrint(url.toString());
  final body = json.encode({'email': email, 'password': password});
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  debugPrint('Login Response status: ${response.statusCode}');
  debugPrint('Login Response body: ${response.body}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}
