import 'package:flutter/material.dart';
import 'package:flutter_thmdb_app/src/shared/consts.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTypography {
  static Text title24(String content,
          {Color color = gray01,
          TextOverflow overFlow,
          TextAlign textAlign,
          FontStyle fontStyle,
          double height}) =>
      _makeTextComponent(content, 18.0, FontWeight.w600,
          color: color, overFlow: overFlow, align: textAlign, height: height);

  static Text title18(String content,
          {Color color = gray01,
          TextOverflow overFlow,
          TextAlign textAlign,
          FontStyle fontStyle,
          double height}) =>
      _makeTextComponent(content, 18.0, FontWeight.w600,
          color: color, overFlow: overFlow, align: textAlign, height: height);

  static Text title12(String content,
          {Color color = gray01,
          TextOverflow overFlow,
          TextAlign textAlign,
          FontStyle fontStyle,
          double height}) =>
      _makeTextComponent(content, 12.0, FontWeight.w600,
          color: color, overFlow: overFlow, align: textAlign, height: height);

  static Text title14(String content,
          {Color color = Colors.white,
          TextOverflow overFlow,
          TextAlign textAlign = TextAlign.left,
          FontStyle fontStyle,
          FontWeight fontWeight = FontWeight.w600,
          double height}) =>
      _makeTextComponent(content, 14.0, fontWeight,
          color: color, overFlow: overFlow, align: textAlign, height: height);

  static Text body10(String content,
          {Color color = Colors.white,
          TextOverflow overFlow,
          TextAlign textAlign = TextAlign.left,
          FontStyle fontStyle,
          FontWeight fontWeight = FontWeight.w400,
          double height}) =>
      _makeTextComponent(content, 10.0, fontWeight,
          color: color, overFlow: overFlow, align: textAlign, height: height);

  static Text body14(String content,
          {Color color,
          TextOverflow overFlow,
          TextAlign textAlign,
          FontStyle fontStyle,
          FontWeight fontWeight = FontWeight.w600,
          double height}) =>
      _makeTextComponent(content, 14.0, fontWeight,
          color: color, overFlow: overFlow, align: textAlign, height: height);

  static Text bodySmall(String content,
          {Color color,
          TextOverflow overFlow,
          TextAlign textAlign,
          FontStyle fontStyle,
          double height}) =>
      _makeTextComponent(content, 14.0, FontWeight.w400,
          color: color, overFlow: overFlow, align: textAlign, height: height);

  ///base para criação das tipografias
  static Text _makeTextComponent(
    String content,
    double size,
    FontWeight fontWeight, {
    Color color,
    TextOverflow overFlow,
    TextAlign align,
    double height,
  }) {
    return Text(
      content,
      style: GoogleFonts.montserrat(
        height: height,
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: overFlow,
      textAlign: align,
    );
  }
}
