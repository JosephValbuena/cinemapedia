import 'package:cinemapedia/infrastructure/datasources/drift_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepitoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasource: DriftDatasource());
});
