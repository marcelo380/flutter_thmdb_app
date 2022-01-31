import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/api/api.dart';
import 'package:flutter_thmdb_app/src/models/movie_list_model.dart';
import 'package:mobx/mobx.dart';

part 'movie_list_mobx.g.dart';

class MoviesMobxCTRL = _MoviesMobxCTRLBase with _$MoviesMobxCTRL;

abstract class _MoviesMobxCTRLBase with Store {
  MovieListModel movieListModel = MovieListModel();

  @observable
  ObservableList<ResultMovie> movieList = ObservableList();

  @observable
  bool paging = false;
  bool isLoading = false;
  int page = 1;

  @computed
  bool get normalLoaded => movieList.isNotEmpty && isLoading == false;

  @computed
  bool get firstLoading => (movieList.isEmpty && isLoading == true);

  @action
  void setLoading(bool value) {
    isLoading = value;
  }

  @action
  void nextPage(BuildContext context) {
    page++;
    fetchMovieList(context);
  }

  @action
  Future fetchMovieList(
    context, {
    int forcePage,
    String query,
  }) async {
    if (page == 1) {
      setLoading(true);
    }

    paging = true;
    if (forcePage != null) {
      page = forcePage;
    }

    await Api.fetchMovieList(
      query: query,
      page: page,
    ).then((response) async {
      if (page == 1) {
        movieListModel = MovieListModel.fromMap(response.data);
      } else {
        movieListModel.results
            .addAll(MovieListModel.fromMap(response.data).results);
      }

      movieList.clear();
      movieList.addAll(movieListModel.results);
      paging = false;
    });
    if (page == 1) {
      setLoading(false);
    }
  }
}
