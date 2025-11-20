import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageProvider = ref.watch(localStorageRepitoryProvider);

  return StorageMoviesNotifier(localStorageRepository: localStorageProvider);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadFavoriteMovies(
        limit: 10, offset: page * 10);
    page++;

    final tempMovies = <int, Movie>{};

    for (final movie in movies) {
      // state = {...state, movie.id: movie};
      tempMovies[movie.id] = movie;
    }

    state = {...state, ...tempMovies};

    return movies;
  }

  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await localStorageRepository.isFavoriteMovie(movie.id);
    print('isFavorite: $isFavorite');
    await localStorageRepository.toggleFavoriteMovie(movie);
    if (isFavorite) {
      state.remove(movie.id);
      state = {...state};
      return;
    }

    state = {...state, movie.id: movie};
  }
}
