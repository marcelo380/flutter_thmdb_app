import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/api/url.dart';
import 'package:flutter_thmdb_app/src/models/movie_list_model.dart';
import 'package:flutter_thmdb_app/src/pages/movie/movie_helper.dart';
import 'package:flutter_thmdb_app/src/shared/utils/typography/typography.dart';
import 'package:flutter_thmdb_app/src/storage/cache/custom_cache_manager_image/custom_cache_manager_image.dart';

class MovieListCard extends StatelessWidget {
  ResultMovie _data;
  MovieListCard(this._data);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      margin: const EdgeInsets.only(
        top: 16,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        child: Stack(
          children: [
            Hero(
              tag: _data.id,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    cacheManager: CustomCacheManager(),
                    imageUrl: Url.getImageUrl(_data.posterPath),
                  )),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.01), Colors.black],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: CustomTypography.title14(_data.title)),
                    CustomTypography.body10(
                      fetchGenreName(_data.genreIds),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
