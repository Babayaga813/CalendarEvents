import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:scheduler/Helpers/ServiceResult/ServiceResult.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../BOs/EventDetailBO.dart';

class LocalDatabase {
  // Singleton pattern implementation
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;

  LocalDatabase._internal();

  static Database? _database;

  // Lazy initialization of the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    try {
      // Get the database path
      String path = join(await getDatabasesPath(), 'events_database.db');
      // Open the database and create it if it doesn't exist
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (e) {
      // Handle any errors that occur during database initialization
      print('Error initializing database: $e');
      rethrow; // Re-throw the exception for further handling if needed
    }
  }

  // Create the tables in the database
  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE events(
          id TEXT PRIMARY KEY,
          createdAt TEXT,
          title TEXT,
          description TEXT,
          status TEXT,
          startAt TEXT,
          duration INTEGER,
          images TEXT
        )
      ''');
    } catch (e) {
      // Handle any errors that occur during table creation
      print('Error creating tables: $e');
      rethrow; // Re-throw the exception for further handling if needed
    }
  }

  // Insert a single event into the database
  Future<void> insertEvent(EventDetail event) async {
    try {
      final db = await database;
      await db.insert('events', event.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      // Handle any errors that occur during the insert operation
      print('Error inserting event: $e');
    }
  }

  // Insert multiple events into the database using a batch
  Future<void> insertEvents(List<EventDetail> events) async {
    try {
      final db = await database;
      Batch batch = db.batch();
      for (var event in events) {
        batch.insert('events', event.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      // Handle any errors that occur during the batch insert operation
      print('Error inserting events: $e');
    }
  }

  // Retrieve all events from the database
  Future<ServiceResult<List<EventDetail>>> getEvents() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('events');
      if (maps.isEmpty) {
        return ServiceResult(
            statusCode: StatusCode.noContent,
            data: [],
            message: "No Data Found");
      } else if (maps.isNotEmpty) {
        return ServiceResult(
            statusCode: StatusCode.ok,
            data: List.generate(maps.length, (i) {
              return EventDetail.fromMap(maps[i]);
            }),
            message: "No Data Found");
      } else {
        return ServiceResult(
            statusCode: StatusCode.expectationFailed,
            data: null,
            message: "unable to fetch data");
      }
    } catch (e) {
      // Handle any errors that occur during the retrieval operation
      debugPrint('Error retrieving events: $e');
      return ServiceResult(
          statusCode: StatusCode.expectationFailed,
          data: null,
          message:
              "Exception caught ${e.toString()}"); // Return an empty list if an error occurs
    }
  }
}
