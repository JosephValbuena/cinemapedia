import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  
  final fetchMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMovies: fetchMovies);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currenPage = 0;

  MovieCallBack fetchMovies;
  MoviesNotifier({required this.fetchMovies}) : super([]);

  Future<void> loadNextPage() async {
    currenPage++;

    final List<Movie> movies = await fetchMovies(page: currenPage);
    state = [...state, ...movies];
  }
}
