import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:MerchForce/data/database-creation.dart';
import 'package:MerchForce/data/process-outgoing.dart';
import 'package:MerchForce/data/process-incoming.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

class Outlet {
  final String name;
  final int id;
  final String latitude;
  final String longitude;
  final String day;

  const Outlet(
      {required this.name,
      required this.id,
      required this.latitude,
      required this.longitude,
      required this.day});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'day': day
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Outlet{id: $id, name: $name, latitude: $latitude, longitude: $longitude, day: $day}';
  }
}

//Get the date
var now = new DateTime.now();

var dayofweek = DateFormat('EEEE').format(now);

final database = databaseCreation();

Future<void> checkDatabase() async {
  final db = await database;
  // TODO If no event on schedule that is function returned nothing then no schedules thus empty.
  // TODO show this on screen using beautiful placeholders.

  final List<Map<String, dynamic>> maps = await db.query('outlets');

  if (maps.isEmpty) {
    checkInternet();
    print("reached");
  } else {
    checkDate();
    print("reached2");
  }
}

// A method that retrieves all the dogs from the dogs table.
Future<void> checkDate() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('outlets');

  if (maps[0]["day"] != dayofweek.toLowerCase()) {
    deleteOutlets();
  }
}

Future<List> returnOutlets() async {
  List data = [];

  checkDatabase();
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('outlets');

  for (final row in maps) {
    data.add([
      row["id"],
      row["name"],
      row["latitude"],
      row["longitude"],
      row["day"]
    ]);
  }

  return data;
}

Future<void> deleteOutlets() async {
  final db = await database;

  await db.rawDelete('DELETE FROM outlets');

  getData();
}
