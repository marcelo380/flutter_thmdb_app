import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_thmdb_app/src/controllers/movie_list_mobx/movie_list_mobx.dart';
import 'package:flutter_thmdb_app/src/models/genre_model.dart';
import 'package:flutter_thmdb_app/src/pages/movie/movie_helper.dart';
import 'package:flutter_thmdb_app/src/pages/movie/movie_list/movie_list_card.dart';
import 'package:flutter_thmdb_app/src/shared/consts.dart';
import 'package:flutter_thmdb_app/src/shared/utils/connectivity/connectivity.dart';
import 'package:flutter_thmdb_app/src/shared/utils/typography/typography.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  TextEditingController _searchQueryCTRL = TextEditingController();
  MoviesMobxCTRL moviesMobxCTRL = MoviesMobxCTRL();
  bool hasConection = false;

  Genre genreSelected;
  @override
  void initState() {
    super.initState();
    _scrollCTRL.addListener(_scrollListener);
    _loadPage();
  }

  @override
  Widget build(BuildContext context) {
    _verifyConnection();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  _loadPage() async {
    moviesMobxCTRL = MoviesMobxCTRL();
    await moviesMobxCTRL.fetchMovieList(context);
  }

  _body() => Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 190.0),
            child: _buildListViewMovieList(),
          ),
          Positioned(
              child: Container(
            height: 220,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.099),
                  ],
                )),
            padding: const EdgeInsets.only(left: 20, right: 20, top: 48),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CustomTypography.title18("Filmes"),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(height: 47, child: _buildSearchField()),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _buildListChipsGenres()),
              ],
            ),
          )),
          !hasConection
              ? Positioned(
                  height: 24.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    color: Colors.red,
                    child: Center(
                      child: CustomTypography.body14("Você está sem internet!",
                          color: Colors.white),
                    ),
                  ),
                )
              : Container(),
        ],
      );

  _buildSearchField() => TextField(
        controller: _searchQueryCTRL,
        cursorColor: gray08,
        onChanged: (query) => _onChangeHandler(() {
          if (query.isNotEmpty) {
            moviesMobxCTRL.fetchMovieList(context, queryText: query);
          } else {
            moviesMobxCTRL.fetchMovieList(context, forcePage: 1);
          }
        }),
        decoration: InputDecoration(
          fillColor: gray08,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: gray02,
          ),
          hintText: "Pesquise filmes",
          hintStyle: const TextStyle(color: gray02),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(100.0),
          ),
          contentPadding: const EdgeInsets.only(top: 17, bottom: 17),
        ),
        style: GoogleFonts.montserrat(
          height: 1.5,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: gray02,
        ),
      );

  _buildListChipsGenres() => List<Widget>.generate(
        categoryOptions.length,
        (int idx) {
          return ChoiceChip(
              label: Text(categoryOptions[idx].name),
              labelStyle: GoogleFonts.montserrat(
                  color: (genreSelected == categoryOptions[idx])
                      ? grayWhite
                      : darkBlue),
              selected: genreSelected == categoryOptions[idx],
              selectedColor: darkBlue,
              backgroundColor: Colors.white,
              onSelected: (selected) {
                _searchQueryCTRL.clear();
                if (genreSelected == categoryOptions[idx]) {
                  moviesMobxCTRL.fetchMovieList(context, forcePage: 1);
                  setState(() {
                    genreSelected = null;
                  });
                } else {
                  moviesMobxCTRL.fetchMovieList(context,
                      genre: categoryOptions[idx].id);
                  setState(() {
                    genreSelected = categoryOptions[idx];
                  });
                }
              });
        },
      ).toList();

  _buildListViewMovieList() {
    return Observer(builder: (_) {
      if (moviesMobxCTRL.notFoundSearch) {
        return CustomTypography.title14("Filme não encontrado",
            color: darkBlue);
      } else if (moviesMobxCTRL.movieList.isNotEmpty) {
        return ListView.builder(
          controller: _scrollCTRL,
          itemCount: moviesMobxCTRL.movieList.length,
          itemBuilder: (context, index) {
            //vamos ignorar filmes sem image,
            //O ideial é tratar com uma imagem padrão.
            if (moviesMobxCTRL.movieList[index].posterPath != null) {
              return GestureDetector(
                onTap: () => navigatorToDetailsMovie(
                  context,
                  moviesMobxCTRL.movieList[index].id,
                  moviesMobxCTRL.movieList[index].posterPath,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: MovieListCard(moviesMobxCTRL.movieList[index])),
              );
            } else {
              return Container();
            }
          },
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator()],
          ),
        );
      }
    });
  }

  ScrollController _scrollCTRL = ScrollController();
  _scrollListener() {
    if (_scrollCTRL.offset >= _scrollCTRL.position.maxScrollExtent &&
        !_scrollCTRL.position.outOfRange) {
      moviesMobxCTRL.nextPage(context);
    }
  }

  Timer searchOnStoppedTyping;

  _onChangeHandler(VoidCallback action) {
    const duration = Duration(milliseconds: 500);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTyping = Timer(duration, action));
  }

  Future<bool> _verifyConnection() async {
    hasConection = await CheckConnectivity.hasConection();

    if (mounted) setState(() {});
    return hasConection;
  }
}
