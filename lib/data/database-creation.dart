import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> databaseCreation() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'outlets_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE outlets(name TEXT, id INTEGER PRIMARY KEY, latitude TEXT, longitude TEXT, day TEXT)',
      );
    },
    version: 1,
  );

  return database;
}
