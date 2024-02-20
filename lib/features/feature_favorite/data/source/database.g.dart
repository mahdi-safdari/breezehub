// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) => _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() => _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null ? await sqfliteDatabaseFactory.getDatabasePath(name!) : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CityDao? _cityDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute('CREATE TABLE IF NOT EXISTS `CityEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `description` TEXT NOT NULL, `icon` TEXT NOT NULL, `temp` REAL NOT NULL, `tempMax` REAL NOT NULL, `tempMin` REAL NOT NULL, `lat` REAL NOT NULL, `lon` REAL NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CityDao get cityDao {
    return _cityDaoInstance ??= _$CityDao(database, changeListener);
  }
}

class _$CityDao extends CityDao {
  _$CityDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cityEntityInsertionAdapter = InsertionAdapter(database, 'CityEntity', (CityEntity item) => <String, Object?>{'id': item.id, 'name': item.name, 'description': item.description, 'icon': item.icon, 'temp': item.temp, 'tempMax': item.tempMax, 'tempMin': item.tempMin, 'lat': item.lat, 'lon': item.lon});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CityEntity> _cityEntityInsertionAdapter;

  @override
  Future<List<CityEntity>> getAllCity() async {
    return _queryAdapter.queryList('SELECT * FROM CityEntity', mapper: (Map<String, Object?> row) => CityEntity(name: row['name'] as String, description: row['description'] as String, icon: row['icon'] as String, temp: row['temp'] as double, tempMax: row['tempMax'] as double, tempMin: row['tempMin'] as double, lat: row['lat'] as double, lon: row['lon'] as double));
  }

  @override
  Future<CityEntity?> findCityByName(String name) async {
    return _queryAdapter.query('SELECT * FROM CityEntity WHERE name = ?1', mapper: (Map<String, Object?> row) => CityEntity(name: row['name'] as String, description: row['description'] as String, icon: row['icon'] as String, temp: row['temp'] as double, tempMax: row['tempMax'] as double, tempMin: row['tempMin'] as double, lat: row['lat'] as double, lon: row['lon'] as double), arguments: [name]);
  }

  @override
  Future<void> deleteCityByName(String name) async {
    await _queryAdapter.queryNoReturn('DELETE FROM CityEntity WHERE name = ?1', arguments: [name]);
  }

  @override
  Future<void> insertCity(CityEntity cityEntity) async {
    await _cityEntityInsertionAdapter.insert(cityEntity, OnConflictStrategy.abort);
  }
}
