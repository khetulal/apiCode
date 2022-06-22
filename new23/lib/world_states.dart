import 'dart:convert';
// ignore: unused_import
import 'package:new23/Model/nepal_states.dart';

import 'package:new23/app_url.dart';
import 'package:http/http.dart' as http;

Future<NepalStates> fetchWorldRecords() async {
  final response = await http.get(Uri.parse(AppUrl.NepalStatesApi));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return NepalStates.fromJson(data);
  } else {
    throw Exception('Error');
  }
}
