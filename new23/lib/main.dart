import 'package:flutter/material.dart';
import 'package:new23/model/nepal_states.dart';
import './world_states.dart';
import 'dart:convert';
import '/model/nepal_states.dart';
import 'package:new23/app_url.dart';
import './detail_screen.dart';
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

void main() {
  runApp(const MaterialApp(
    title: 'covid-19',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<NepalStates>? data;
  @override
  void initState() {
    super.initState();
    data = fetchWorldRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<NepalStates>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DetailScreen(
              image: 'https://picsum.photos/250?image=9',
              name: snapshot.data!.country,
              totalCases: snapshot.data!.cases,
              totalDeaths: snapshot.data!.deaths,
              totalRecovered: snapshot.data!.recovered,
              active: snapshot.data!.active,
              critical: snapshot.data!.critical,
              todayRecovered: snapshot.data!.todayRecovered,
              test: snapshot.data!.tests,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
