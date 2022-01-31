import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/api/api.dart';
import 'package:flutter_thmdb_app/src/api/url.dart';
import 'package:flutter_thmdb_app/src/components/back_button/back_button.dart';
import 'package:flutter_thmdb_app/src/components/widget_box/widget_box.dart';
import 'package:flutter_thmdb_app/src/models/credits_model.dart';
import 'package:flutter_thmdb_app/src/models/movie_details_model.dart';
import 'package:flutter_thmdb_app/src/shared/consts.dart';
import 'package:flutter_thmdb_app/src/shared/utils/typography/typography.dart';
import 'package:flutter_thmdb_app/src/storage/image_cache/custom_cache_manager.dart';

class MovieDetailsPage extends StatefulWidget {
  MovieDetailsPage(this.movieID, this.imageUrl);
  final int movieID;
  final String imageUrl;
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Animation<double> controller;
  Animation<Offset> buttonAnimationTrans;
  Animation<Offset> textAnimationTrans;
  MovieDetailsModel movieViewModel;
  CreditsModel creditsModel;
  @override
  void initState() {
    _loadMovieInfo();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (controller == null) {
      controller = ModalRoute.of(context).animation;

      textAnimationTrans = Tween(
        begin: const Offset(0.0, 10.0),
        end: const Offset(0.0, 0.0),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.8, curve: Curves.linear),
        ),
      );

      buttonAnimationTrans = Tween(
        begin: const Offset(-5.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.68, curve: Curves.linear),
        ),
      );
    }
  }

  Future _loadMovieInfo() async {
    var resMovieInfo = await Api.fetchMovieInfo(widget.movieID);
    var resCreditsInfo = await Api.fetchCredits(widget.movieID);

    movieViewModel = MovieDetailsModel.fromMap(resMovieInfo.data);
    creditsModel = CreditsModel.fromMap(resCreditsInfo.data);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: 360,
                color: gray08,
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.only(left: 20, top: 48, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: MBackButton(
                        controller: controller,
                        textTranslation: textAnimationTrans,
                        buttonTranslation: buttonAnimationTrans,
                        callback: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(
                      height: 65,
                    ),
                    Container(
                      width: size.width * 0.65,
                      child: Hero(
                        tag: widget.movieID,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            child: CachedNetworkImage(
                              cacheManager: CustomCacheManager(),
                              imageUrl: Url.getImageUrl(widget.imageUrl),
                            )),
                      ),
                    ),
                    movieViewModel != null
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 32,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomTypography.title24(movieViewModel
                                          .voteAverage
                                          .toString()),
                                      CustomTypography.body14(' /10',
                                          color: gray03),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  CustomTypography.title14(movieViewModel.title,
                                      color: gray01),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTypography.body10(
                                          "TÍTULO ORIGINAL: ",
                                          color: gray02),
                                      CustomTypography.body10(
                                          movieViewModel.originalTitle,
                                          color: gray02,
                                          fontWeight: FontWeight.w600),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BoxWidget(
                                        type: 0,
                                        widget: [
                                          CustomTypography.title14('Ano: ',
                                              color: gray03),
                                          Flexible(
                                            child: CustomTypography.title14(
                                                movieViewModel.releaseDate.year
                                                    .toString(),
                                                color: gray01),
                                          ),
                                        ],
                                      ),
                                      BoxWidget(
                                        type: 0,
                                        widget: [
                                          CustomTypography.title14('Duração: ',
                                              color: gray03),
                                          Flexible(
                                            child: CustomTypography.title14(
                                                _calculeDuration(),
                                                color: gray01),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Wrap(
                                    spacing: 16,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.spaceEvenly,
                                    runAlignment: WrapAlignment.spaceEvenly,
                                    children: List.generate(
                                      movieViewModel.genres.length,
                                      (index) => BoxWidget(
                                        type: 1,
                                        widget: [
                                          CustomTypography.title14(
                                              movieViewModel.genres[index].name,
                                              color: gray03),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 56,
                                  ),
                                  _buildTitleAndText(
                                    title: 'Descrição',
                                    text: movieViewModel.overview,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    width: size.width,
                                    child: BoxWidget(
                                      type: 0,
                                      widget: [
                                        CustomTypography.title14('ORÇAMENTO: ',
                                            color: gray03),
                                        Flexible(
                                          child: CustomTypography.title14(
                                              movieViewModel.budget.toString(),
                                              color: gray01),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    width: size.width,
                                    child: BoxWidget(
                                      type: 0,
                                      widget: [
                                        CustomTypography.title14(
                                            'PRODUTORAS:  ',
                                            color: gray03),
                                        Flexible(
                                          child: CustomTypography.title14(
                                              fetchProdutionCompanies(),
                                              color: gray01),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  _buildTitleAndText(
                                    title: 'Diretor',
                                    text: fetchDirector(creditsModel),
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  _buildTitleAndText(
                                    title: 'Elenco',
                                    text: fetchCast(creditsModel.cast),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 90,
                              ),
                            ],
                          )
                        : CircularProgressIndicator()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _calculeDuration() {
    Duration _duration = Duration(minutes: movieViewModel.runtime);
    int min = movieViewModel.runtime - (_duration.inHours * 60);
    return '${_duration.inHours}h $min min';
  }

  fetchProdutionCompanies() {
    String productionCompaniesName = "";
    movieViewModel.productionCompanies.forEach((e) {
      productionCompaniesName += e.name;
    });
    return productionCompaniesName;
  }

  String fetchCast(List cast) {
    String result = "";
    cast.forEach((e) {
      result += e.name + ", ";
    });

    return result;
  }

  String fetchDirector(CreditsModel creditsModel) {
    String res = creditsModel.crew
        .firstWhere((element) => element.job == "Director")
        .name;
    List nameSplit = res.split(" ");

    return nameSplit[0] + " " + nameSplit[1];
  }

  _buildTitleAndText({@required String title, @required String text}) =>
      Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTypography.body14(title, color: gray02),
            const SizedBox(
              height: 8,
            ),
            CustomTypography.title12(text, color: gray01)
          ],
        ),
      );
}
