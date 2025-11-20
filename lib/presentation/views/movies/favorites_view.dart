import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider);
    final myMovieList = favoriteMovies.values.toList();

    final colorPrimary = Theme.of(context).colorScheme.primary;

    if (myMovieList.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 100, color: colorPrimary),
              Text('No tienes películas favoritas', style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
      );
    }

    return Scaffold(
        body: MovieMasonry(
      movies: myMovieList,
      loadNextPage: () =>
          ref.read(favoriteMoviesProvider.notifier).loadNextPage(),
    )
        // ListView.builder(
        //     itemCount: favoriteMovies.keys.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       final movie = myMovieList[index];
        //       return ListTile(
        //         title: Text(movie.title),
        //       );
        //     }),
        );
  }
}
