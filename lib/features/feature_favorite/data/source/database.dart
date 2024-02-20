import 'dart:async';

import 'package:breezehub/features/feature_favorite/data/source/city_dao.dart';
import 'package:breezehub/features/feature_favorite/domain/entities/city_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [CityEntity])
abstract class AppDatabase extends FloorDatabase {
  CityDao get cityDao;
}
