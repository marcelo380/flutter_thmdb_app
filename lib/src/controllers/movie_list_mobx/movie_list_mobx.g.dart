// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MoviesMobxCTRL on _MoviesMobxCTRLBase, Store {
  Computed<bool> _$normalLoadedComputed;

  @override
  bool get normalLoaded =>
      (_$normalLoadedComputed = Computed<bool>(() => super.normalLoaded,
              name: '_MoviesMobxCTRLBase.normalLoaded'))
          .value;
  Computed<bool> _$firstLoadingComputed;

  @override
  bool get firstLoading =>
      (_$firstLoadingComputed = Computed<bool>(() => super.firstLoading,
              name: '_MoviesMobxCTRLBase.firstLoading'))
          .value;
  Computed<bool> _$notFoundSearchComputed;

  @override
  bool get notFoundSearch =>
      (_$notFoundSearchComputed = Computed<bool>(() => super.notFoundSearch,
              name: '_MoviesMobxCTRLBase.notFoundSearch'))
          .value;

  final _$movieListAtom = Atom(name: '_MoviesMobxCTRLBase.movieList');

  @override
  ObservableList<ResultMovie> get movieList {
    _$movieListAtom.reportRead();
    return super.movieList;
  }

  @override
  set movieList(ObservableList<ResultMovie> value) {
    _$movieListAtom.reportWrite(value, super.movieList, () {
      super.movieList = value;
    });
  }

  final _$pagingAtom = Atom(name: '_MoviesMobxCTRLBase.paging');

  @override
  bool get paging {
    _$pagingAtom.reportRead();
    return super.paging;
  }

  @override
  set paging(bool value) {
    _$pagingAtom.reportWrite(value, super.paging, () {
      super.paging = value;
    });
  }

  final _$nextPageAsyncAction = AsyncAction('_MoviesMobxCTRLBase.nextPage');

  @override
  Future nextPage(BuildContext context) {
    return _$nextPageAsyncAction.run(() => super.nextPage(context));
  }

  final _$fetchMovieListAsyncAction =
      AsyncAction('_MoviesMobxCTRLBase.fetchMovieList');

  @override
  Future<dynamic> fetchMovieList(dynamic context,
      {int forcePage, String queryText, int genre}) {
    return _$fetchMovieListAsyncAction.run(() => super.fetchMovieList(context,
        forcePage: forcePage, queryText: queryText, genre: genre));
  }

  final _$_MoviesMobxCTRLBaseActionController =
      ActionController(name: '_MoviesMobxCTRLBase');

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_MoviesMobxCTRLBaseActionController.startAction(
        name: '_MoviesMobxCTRLBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_MoviesMobxCTRLBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
movieList: ${movieList},
paging: ${paging},
normalLoaded: ${normalLoaded},
firstLoading: ${firstLoading},
notFoundSearch: ${notFoundSearch}
    ''';
  }
}
