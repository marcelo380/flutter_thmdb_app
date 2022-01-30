import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/shared/consts.dart';
import 'package:flutter_thmdb_app/src/shared/utils/typography/typography.dart';

class MBackButton extends StatelessWidget {
  MBackButton(
      {this.textTranslation,
      this.controller,
      this.buttonTranslation,
      this.callback});

  final Animation<Offset> textTranslation;
  final Animation<Offset> buttonTranslation;
  final Animation<double> controller;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return FractionalTranslation(
            translation: buttonTranslation.value,
            child: Container(
               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: gray02,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FractionalTranslation(
                      translation: textTranslation.value,
                      child: CustomTypography.title14('Voltar',
                          color: gray02, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
