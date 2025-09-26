import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScrenLoader(); 

    final moviesSlideShow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.all(0),
          title: CustomAppbar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // CustomAppbar(),
            MoviesSlideshow(movies: moviesSlideShow),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cines',
              subTitle: 'Lunes 20',
              loadNextPage: () {
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: upComingMovies,
              title: 'Próximamente',
              subTitle: 'En este mes',
              loadNextPage: () {
                ref.read(upComingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              subTitle: 'Siempre',
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor calificadas',
              subTitle: 'Aclamadas!',
              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 1))
    ]);
  }
}
