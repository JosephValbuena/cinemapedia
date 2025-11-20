import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFavoriteMovieProvider =
    FutureProvider.family.autoDispose<bool, int>((ref, movieId) {
  final localStorageRepository = ref.watch(localStorageRepitoryProvider);
  return localStorageRepository.isFavoriteMovie(movieId);
});
