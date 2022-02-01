import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/api/api.dart';
import 'package:flutter_thmdb_app/src/models/movie_list_model.dart';
import 'package:flutter_thmdb_app/src/shared/utils/connectivity/connectivity.dart';
import 'package:flutter_thmdb_app/src/storage/cache/cache_movie_list/cache_movie_list.dart';

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
  String queryTextBkp;

  @computed
  bool get normalLoaded => movieList.isNotEmpty && isLoading == false;

  @computed
  bool get firstLoading => (movieList.isEmpty && isLoading == true);

  @computed
  bool get notFoundSearch => (movieList.isEmpty && queryTextBkp != null);

  @action
  void setLoading(bool value) {
    isLoading = value;
  }

  @action
  Future nextPage(BuildContext context) async {
    if (await CheckConnectivity.hasConection()) {
      page++;
      await fetchMovieList(context);
    }
  }

  @action
  Future fetchMovieList(
    context, {
    int forcePage,
    String queryText,
    int genre,
  }) async {
    queryTextBkp = queryText;
    //verificar conexao
    if (await CheckConnectivity.hasConection()) {
      _hasConnection(queryText, genre, forcePage);
    } else {
      await _noConnection(queryText, genre);
    }
  }

  Future _hasConnection(String queryText, int genre, forcePage) async {
    if (page == 1) {
      setLoading(true);
    }

    paging = true;
    if (forcePage != null) {
      page = forcePage;
    }

    await Api.fetchMovieList(query: queryText, page: page, genre: genre)
        .then((response) async {
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
  }

  Future _noConnection(String queryText, int genre) async {
    List<ResultMovie> movieOfflineList = await CacheMovieList.readMovieList();
    //cria seach offline
    if (queryText != null && movieOfflineList != null) {
      movieList.clear();

      List<ResultMovie> listSearch = movieOfflineList
          .where((item) =>
              item.title.toLowerCase().contains(queryText.toLowerCase()))
          .toList();

      movieList.addAll(listSearch);
      //cria seleção de generos offline
    } else if (genre != null) {
      movieList.clear();

      List<ResultMovie> listSearch = movieOfflineList
          .where((item) => item.genreIds.contains(genre))
          .toList();

      movieList.addAll(listSearch);
      //se não utilizar filtros so popula a listagem
    } else {
      movieList.clear();
      movieList.addAll(movieOfflineList);
    }
  }
}
