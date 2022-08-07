import 'package:MerchForce/data/database-creation.dart';
// import 'package:MerchForce/data/process-outgoing.dart';
import 'package:MerchForce/data/schedules.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

//Upon internet connection check if database has something.

//If database has something then check what it is using the date today
//Check if date-value of random task matches the date for today
//if matches do not load new data from internet
//if it does not match call process-outgoing

//if database has nothing then call data from the internet
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

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
        id: json['id'],
        name: json['name'],
        longitude: json["longitude"],
        latitude: json["latitude"],
        day: json["day"]);
  }
}

Future<void> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      getData();
    }
  } on SocketException catch (_) {
    print('not connected');
  }
}

Future<void> getData() async {
  final db = await database;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  final employeecode = prefs.getString("employeecode");

  var connection = PostgreSQLConnection(
      "databasemerchforce.crsslmuuogyz.us-east-1.rds.amazonaws.com",
      5432,
      "merchforce",
      username: "postgres",
      password: "SAkiniolinga123a");
  await connection.open();

  var dayid;

  var now = new DateTime.now();

  var dayofweek = DateFormat('EEEE').format(now);

  for (final day in daydict) {
    if (day.toDict()["dayname"] == dayofweek.toLowerCase()) {
      dayid = day.toDict()["dayid"];
    }
  }
  print(dayid);

  //TODO select schedules using day id rather than day name
  List<List<dynamic>> results = await connection.query(
      '''SELECT schedules.scheduleid, stores.storename, stores.storelatitude, stores.storelongitude, days.dayname
        FROM schedules 
        INNER JOIN stores ON schedules.storeid = stores.storeid
        INNER JOIN  days ON schedules.dayid = days.dayid
        WHERE schedules.employeeid = @employeecode AND schedules.dayid = @dayid;
      ''',
      substitutionValues: {"employeecode": employeecode, "dayid": dayid});
  print(results);
  try {
    for (final row in results) {
      var outlet = Outlet(
          id: row[0],
          name: row[1].toString(),
          latitude: row[2].toString(),
          longitude: row[3].toString(),
          day: row[4].toString()); //row[4].toString());
      await db.insert(
        'outlets',
        outlet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  } on RangeError {
    print("No schedule for today");
  }
  ;
  if (results.isNotEmpty) {
    returnOutlets();
  } else {
    return null;
  }
}

class Day {
  final int dayid;
  final String dayname;

  const Day({required this.dayid, required this.dayname});

  toDict() {
    var details = new Map<String, dynamic>();
    details["dayid"] = dayid;
    details["dayname"] = dayname;
    return details;
  }
}

var dayid;

const List<Day> daydict = [
  const Day(dayid: 1, dayname: "monday"),
  const Day(dayid: 2, dayname: "tuesday"),
  const Day(dayid: 3, dayname: "wednesday"),
  const Day(dayid: 4, dayname: "thursday"),
  const Day(dayid: 5, dayname: "friday"),
  const Day(dayid: 6, dayname: "saturday"),
  const Day(dayid: 7, dayname: "sunday"),
];
