import "package:flutter/foundation.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import "UI/myApp.dart";
import "package:sqflite/sqflite.dart";
import "package:sqflite_common_ffi_web/sqflite_ffi_web.dart";
import "package:path/path.dart";

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  // À mettre juste avant openDatabase, temporairement
    final database = openDatabase(
    join(await getDatabasesPath(), 'task_database.db'),
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, nbhours INTEGER, difficulty INTEGER)'
      );
      await db.execute(
          'CREATE TABLE tags (id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, task_id INTEGER, FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE)'
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      await db.execute('DROP TABLE IF EXISTS tags');
      await db.execute('DROP TABLE IF EXISTS task');
      await db.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, nbhours INTEGER, difficulty INTEGER)'
      );
      await db.execute(
          'CREATE TABLE tags (id INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, task_id INTEGER, FOREIGN KEY (task_id) REFERENCES task(id) ON DELETE CASCADE)'
      );
    },
  );
  final db = await database;
  await db.execute('PRAGMA foreign_keys = ON');
  runApp(MyApp(db));
}
