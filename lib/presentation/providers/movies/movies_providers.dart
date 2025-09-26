import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMovies: fetchMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMovies: fetchMovies);
});

final upComingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fetchMovies: fetchMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMovies: fetchMovies);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currenPage = 0;
  bool isLoading = false;
  MovieCallBack fetchMovies;
  MoviesNotifier({required this.fetchMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currenPage++;

    final List<Movie> movies = await fetchMovies(page: currenPage);
    state = [...state, ...movies];
    isLoading = false;
  }
}
