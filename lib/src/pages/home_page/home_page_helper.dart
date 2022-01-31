import 'package:flutter/cupertino.dart';
import 'package:flutter_thmdb_app/src/pages/movie_details/movie_details.dart';
import 'package:flutter_thmdb_app/src/shared/singleton/genre_singleton.dart';

navigatorToDetailsMovie(
  context,
  int movieId,
  String imageUrl,
) async =>
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return MovieDetailsPage(movieId, imageUrl);
          },
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation =
                CurvedAnimation(curve: Curves.decelerate, parent: animation);
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          }),
    );


String fetchGenreName(List genreIDs) {
  GenreSingleton genreSingleton = GenreSingleton();
  String genre = "";

  for (var i = 0; i < genreIDs.length; i++) {
    String resName = genreSingleton.genreModel.genres
        .firstWhere((element) => element.id == genreIDs[i])
        .name;

    if (i == genreIDs.length - 1) {
      genre += "$resName.";
    } else {
      genre += "$resName, ";
    }
  }

  return genre;
}