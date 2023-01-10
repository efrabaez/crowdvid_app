import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:crowdvid/models/user_model.dart';
import 'constants.dart' as constants;

Future<User> createUser(
    String email, String password, String name, String lastname) async {
  final url = Uri.https(constants.apiBaseURL, constants.userRegister);
  debugPrint(url.toString());
  final body = json.encode(
    {'email': email, 'password': password, 'name': email, 'lastname': lastname},
  );
  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: body,
  );
  debugPrint('Register Response status: ${response.statusCode}');
  debugPrint('Register Response body: ${response.body}');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to create User');
  }
}
