import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/shared/utils/typography/typography.dart';

class MovieCard extends StatelessWidget {
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
              tag: {},
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: Image.network(
                  'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTMEDMzGG1lkpnENo3hRNA6TSyZqWuGKc2GR0qg6z3j8Ca3AYlx',
                ),
              ),
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
                        child: CustomTypography.title14("Nome Filme")),
                    CustomTypography.body10(
                      " Categorias",
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
