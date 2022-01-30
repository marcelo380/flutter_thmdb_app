import 'package:flutter/cupertino.dart';
import 'package:flutter_thmdb_app/src/shared/consts.dart';
import 'package:flutter_thmdb_app/src/shared/utils/typography/typography.dart';

class InfoBox extends StatelessWidget {
  InfoBox({this.leadingText, this.text});

  final String leadingText, text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
          color: gray08, borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTypography.title14(leadingText, color: gray03),
          Flexible(
            child: CustomTypography.title14(text, color: gray01),
          ),
        ],
      ),
    );
  }
}
