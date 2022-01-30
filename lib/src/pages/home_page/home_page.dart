import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/pages/home_page/home_card.dart';
import 'package:flutter_thmdb_app/src/shared/consts.dart';
import 'package:flutter_thmdb_app/src/shared/utils/typography/typography.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchQueryCTRL = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollCTRL.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  _body() => Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 190.0),
            child: ListView.builder(
              controller: _scrollCTRL,
              itemCount: 15,
              itemBuilder: (context, index) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: MovieCard());
              },
            ),
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
                SizedBox(
                    height: 47,
                    child: TextField(
                      controller: _searchQueryCTRL,
                      cursorColor: gray08,
                      onChanged: (query) => _onChangeHandler(() {}),
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
                        contentPadding:
                            const EdgeInsets.only(top: 17, bottom: 17),
                      ),
                      style: GoogleFonts.montserrat(
                        height: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: gray02,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text("Ação"),
                      backgroundColor: darkBlue,
                      labelStyle: GoogleFonts.montserrat(color: grayWhite),
                    ),
                    Chip(label: Text("Aventura")),
                    Chip(label: Text("Fantasia")),
                    Chip(label: Text("Comédia")),
                  ],
                ),
              ],
            ),
          )),
        ],
      );

  ScrollController _scrollCTRL = ScrollController();
  _scrollListener() {
    if (_scrollCTRL.offset >= _scrollCTRL.position.maxScrollExtent &&
        !_scrollCTRL.position.outOfRange) {
      // troca pagina
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
}
