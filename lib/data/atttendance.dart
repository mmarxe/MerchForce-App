import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:MerchForce/data/database-creation.dart';

class Attendance {
  final int storeid;
  final bool attendance;

  const Attendance({required this.storeid, required this.attendance});

  Map<String, dynamic> toMap() {
    return {
      'storeid': storeid,
      'attendance': attendance,
    };
  }

  @override
  String toString() {
    return 'Outlet{storeid: $storeid, attendance: $attendance}';
  }
}

final database = databaseCreation();

Future<void> confirmAttendance(Attendance attendance) async {
  // Get a reference to the database.
  final db = await database;

  await db.insert(
    'attendance',
    attendance.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
