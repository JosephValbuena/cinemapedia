import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsDatasourcer {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
