import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    // Return the existing database instance if available
    if (_database != null) return _database!;

    // Initialize the database if it doesn't exist yet
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'tugas.db');

    // Open the database, creating it if necessary
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Method to create the table when the database is first created
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tugas (
        judul TEXT PRIMARY KEY NOT NULL,
        matkul TEXT NOT NULL,
        tanggal TEXT NOT NULL,
        frek TEXT NOT NULL,
        waktu TEXT NOT NULL
      )
    ''');
  }
}
