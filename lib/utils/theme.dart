import 'package:flutter/material.dart';

const Color kBackground = Color(0XFF9381FF);
const Color kTextPrimary = Color(0XFF000000);
const Color kTextSecondary = Color(0XFF293C80);
const Color kMuted = Color(0XFFD4D4D4);
const Color kIconBg = Color(0XFFE7E5F3);
const Color kWhite = Color(0XFFFFFFFF);

themeData(context) => ThemeData(
      fontFamily: "Aeonik",
      primaryColor: kBackground,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
