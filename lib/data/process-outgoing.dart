import 'package:MerchForce/data/database-creation.dart';
import 'package:MerchForce/data/process-outgoing.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

final database = databaseCreation();

Future<void> getPostgres() async {
  var connection = PostgreSQLConnection("localhost", 5432, "dart_test",
      username: "dart", password: "dart");
  await connection.open();

  List<List<dynamic>> results = await connection.query(
      "SELECT a, b FROM table WHERE a = @aValue",
      substitutionValues: {"aValue": 3});

  for (final row in results) {
    var a = row[0];
    var b = row[1];
  }
}

Future<Outlet> sendDataToServer(maps) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': maps[""],
    }),
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Outlet.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class Outlet {
  final String name;
  final int id;
  final String latitude;
  final String longitude;

  const Outlet(
      {required this.name,
      required this.id,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
        id: json['id'],
        name: json['name'],
        longitude: json["longitude"],
        latitude: json["latitude"]);
  }
}
