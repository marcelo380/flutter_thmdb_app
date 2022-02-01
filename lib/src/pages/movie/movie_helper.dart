import 'package:flutter/cupertino.dart';
import 'package:flutter_thmdb_app/src/models/credits_model.dart';
import 'package:flutter_thmdb_app/src/models/genre_model.dart';
import 'package:flutter_thmdb_app/src/pages/movie/movie_details/movie_details.dart';

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

List<Genre> categoryOptions = [
  Genre(id: 28, name: 'Ação'),
  Genre(id: 12, name: 'Aventura'),
  Genre(id: 14, name: 'Fantasia'),
  Genre(id: 35, name: 'Comédia'),
];

String calculeDurationMovie(movieViewModel) {
  Duration _duration = Duration(minutes: movieViewModel.runtime);
  int min = movieViewModel.runtime - (_duration.inHours * 60);
  return '${_duration.inHours}h $min min';
}

String fetchDirector(CreditsModel creditsModel) {
  String res =
      creditsModel.crew.firstWhere((element) => element.job == "Director").name;
  List nameSplit = res.split(" ");

  return nameSplit[0] + " " + nameSplit[1];
}

String fetchCast(List cast) {
  String result = "";
  cast.forEach((e) {
    result += e.name + ", ";
  });

  return result;
}

fetchProdutionCompanies(movieDetailsModel) {
  String productionCompaniesName = "";
  movieDetailsModel.productionCompanies.forEach((e) {
    productionCompaniesName += e.name;
  });
  return productionCompaniesName;
}
