import 'package:flutter/cupertino.dart';
import 'package:flutter_thmdb_app/src/shared/consts.dart';
import 'package:flutter_thmdb_app/src/shared/utils/typography/typography.dart';

class BoxWidget extends StatelessWidget {
  BoxWidget({this.widget, this.type});

  /// 0= Box de informação cinza, 1= box de informação branco
  final List<Widget> widget;
  final int type;

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration;
    if (type == 0) {
      boxDecoration = const BoxDecoration(
          color: gray08, borderRadius: BorderRadius.all(Radius.circular(8)));
    } else if (type == 1) {
      boxDecoration = BoxDecoration(
          border: Border.all(color: gray02, width: 0.1),
          borderRadius: const BorderRadius.all(Radius.circular(5)));
    } else {
      throw ("Os valores devem ser entre 0 e 1");
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: boxDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget,
      ),
    );
  }
}
