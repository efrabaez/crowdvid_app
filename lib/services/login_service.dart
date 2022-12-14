import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:crowdvid/models/user_model.dart';

Future<User> fetchUser() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

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
