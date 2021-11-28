import 'dart:io';

import 'package:office_reservation/repository/model/location.dart';
import 'package:office_reservation/repository/model/place.dart';
import 'package:office_reservation/repository/model/place_info.dart';
import 'package:office_reservation/repository/model/reservation.dart';
import 'package:office_reservation/repository/model/reservation_info.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // database table names
  static const String _tableLocations = 'locations';
  static const String _tablePlaces = 'places';
  static const String _tableReservations = 'reservations';

  static const String _dbName = "office_reservation.db";
  static const int _dbVersion = 1;

  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();

  static late Database _database;

  Future<Database> get database async {
    try {
      _database = await _initDb();
    } catch (e) {
      await _deleteDb();
      _database = await _initDb();
    }
    return _database;
  }

  Future<Database> _initDb() async {
    String path = await _getDbPath();
    final db = await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate, onConfigure: _onConfigure);
    return db;
  }

  _deleteDb() async {
    String path = await _getDbPath();
    await deleteDatabase(path);
  }

  Future<String> _getDbPath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return path;
  }

  _onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future _onCreate(Database db, int version) async {
    var batch = db.batch();
    batch.execute('''
              CREATE TABLE $_tableLocations (
                ${Location.columnId} INTEGER PRIMARY KEY,
                ${Location.columnName} TEXT NOT NULL,
                ${Location.columnImagePath} TEXT
              )
              ''');

    batch.execute('''
              CREATE TABLE $_tablePlaces (
                ${Place.columnId} INTEGER PRIMARY KEY,
                ${Place.columnLocationId} INTEGER NOT NULL,
                ${Place.columnXCoordinateMultiplier} REAL NOT NULL,
                ${Place.columnYCoordinateMultiplier} REAL NOT NULL,
                ${Place.columnHeightMultiplier} REAL NOT NULL,
                ${Place.columnWidthMultiplier} REAL NOT NULL,
                ${Place.columnOriginalHeight} REAL NOT NULL,
                ${Place.columnOriginalWidth} REAL NOT NULL,
                FOREIGN KEY(${Place.columnLocationId}) REFERENCES $_tableLocations(${Location.columnId})
              )
              ''');

    batch.execute('''
              CREATE TABLE $_tableReservations (
                ${Reservation.columnId} INTEGER PRIMARY KEY,
                ${Reservation.columnPlaceId} INTEGER NOT NULL,
                ${Reservation.columnReservationDateTime} TEXT NOT NULL,
                FOREIGN KEY(${Reservation.columnPlaceId}) REFERENCES $_tablePlaces(${Place.columnId})
              )
              ''');

    // inserting initial data
    batch.insert(
        _tableLocations, Location(1, "Кузнецкий мост #303", null).toMap());
    batch.insert(
        _tableLocations, Location(2, "Кузнецкий мост #404", null).toMap());

    batch.insert(
        _tablePlaces, Place(1, 1, 0.05, 0.1, 0.12, 0.15, 790, 411).toMap());
    batch.insert(
        _tablePlaces, Place(2, 1, 0.05, 0.3, 0.12, 0.15, 790, 411).toMap());
    batch.insert(
        _tablePlaces, Place(3, 1, -0.3, 0.1, 0.12, 0.15, 790, 411).toMap());

    batch.insert(
        _tablePlaces, Place(4, 2, 0.05, 0.1, 0.12, 0.15, 790, 411).toMap());
    batch.insert(
        _tablePlaces, Place(5, 2, 0.05, 0.3, 0.12, 0.15, 790, 411).toMap());
    batch.insert(
        _tablePlaces, Place(6, 2, -0.3, 0.1, 0.12, 0.15, 790, 411).toMap());
    batch.insert(
        _tablePlaces, Place(7, 2, -0.3, 0.3, 0.07, 0.2, 790, 411).toMap());

    batch.insert(_tableReservations, Reservation(1, 3, DateTime.now().toUtc()).toMap());
    batch.insert(_tableReservations,
        Reservation(2, 3, DateTime.utc(2021, 11, 12)).toMap());
    batch.insert(_tableReservations, Reservation(3, 6, DateTime.now().toUtc()).toMap());
    batch.insert(_tableReservations,
        Reservation(4, 5, DateTime.utc(2021, 10, 16)).toMap());

    await batch.commit(noResult: true);
  }

  Future<List<Location>> getLocations() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      _tableLocations,
    );
    List<Location> result = [];
    if (maps.isNotEmpty) {
      for (var element in maps) {
        result.add(Location.fromMap(element));
      }
    }
    return result;
  }

  Future<List<PlaceInfo>> getPlaceInfoList(int locationId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.rawQuery(
      """
      SELECT ${Place.columnId}, ${Place.columnLocationId},
             ${Place.columnXCoordinateMultiplier}, ${Place.columnYCoordinateMultiplier},
             ${Place.columnHeightMultiplier}, ${Place.columnWidthMultiplier},
             ${Place.columnOriginalHeight}, ${Place.columnOriginalWidth},
             EXISTS(
               SELECT * FROM $_tableReservations
               WHERE ${Reservation.columnPlaceId} = $_tablePlaces.${Place.columnId} AND
                 DATETIME(${Reservation.columnReservationDateTime}) >= DATE('now')
             ) ${PlaceInfo.columnIsReserved}
      FROM $_tablePlaces
      WHERE ${Place.columnLocationId} = $locationId
      """,
    );
    List<PlaceInfo> result = [];
    if (maps.isNotEmpty) {
      for (var element in maps) {
        result.add(PlaceInfo.fromMap(element));
      }
    }
    return result;
  }

  Future<void> addReservation(Reservation reservation) async {
    Database db = await database;
    await db.insert(_tableReservations, reservation.toMap());
  }

  Future<List<ReservationInfo>> getReservationInfoList() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.rawQuery(
      """
      SELECT $_tableReservations.${Reservation.columnId},
             $_tableReservations.${Reservation.columnPlaceId},
             $_tableReservations.${Reservation.columnReservationDateTime},
             $_tableLocations.${Location.columnName}
      FROM $_tableReservations
      INNER JOIN $_tablePlaces
      ON $_tableReservations.${Reservation.columnPlaceId} = $_tablePlaces.${Place.columnId}
      INNER JOIN $_tableLocations
      ON $_tablePlaces.${Place.columnLocationId} = $_tableLocations.${Location.columnId}
      ORDER BY DATETIME(${Reservation.columnReservationDateTime}) DESC
      """,
    );
    List<ReservationInfo> result = [];
    if (maps.isNotEmpty) {
      for (var element in maps) {
        result.add(ReservationInfo.fromMap(element));
      }
    }
    return result;
  }
}
