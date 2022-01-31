import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/api/api.dart';
import 'package:flutter_thmdb_app/src/models/movie_list_model.dart';
import 'package:flutter_thmdb_app/src/shared/utils/connectivity/connectivity.dart';
import 'package:flutter_thmdb_app/src/storage/cache/cache_movie_list.dart';

import 'package:mobx/mobx.dart';

part 'movie_list_mobx.g.dart';

class MoviesMobxCTRL = _MoviesMobxCTRLBase with _$MoviesMobxCTRL;

abstract class _MoviesMobxCTRLBase with Store {
  MovieListModel _movieListModel = MovieListModel();

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
    //verificar conexao
    if (await CheckConnectivity.hasConection()) {
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
          _movieListModel = MovieListModel.fromMap(response.data);
          //guarda dados para uso offline
          await CacheMovieList.insertMovieList(_movieListModel.results);
        } else {
          _movieListModel.results
              .addAll(MovieListModel.fromMap(response.data).results);
          //para evitar fica jogando lista completa
          await CacheMovieList.insertMovieList(
              MovieListModel.fromMap(response.data).results);
        }

        movieList.clear();
        movieList.addAll(_movieListModel.results);

        paging = false;
      });
      if (page == 1) {
        setLoading(false);
      }

      //tenta carregar dados offline
    } else {
      List<ResultMovie> movieOfflineList = await CacheMovieList.readMovieList();

      if (movieOfflineList != null || movieList.isNotEmpty) {
        movieList.addAll(movieOfflineList);
      }
    }
  }
}
