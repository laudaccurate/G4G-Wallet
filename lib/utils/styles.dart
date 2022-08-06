import 'package:flutter/material.dart';

// final kScreenHeight = MediaQuery.of(context)

final kTitleStyle = TextStyle(
  color: Colors.blueGrey,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kInputLabelStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  color: Colors.grey[700],
);

final kAuthInputLabelStyle = TextStyle(
  color: Colors.grey[700],
  fontSize: 13.0,
);

final kDropdownItemStyle = TextStyle(
  color: Colors.grey[700],
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
);

final kDropdownHeaderStyle = TextStyle(
  color: Colors.grey[700],
  fontWeight: FontWeight.w600,
  fontSize: 14.0,
);

final kSubtitleStyle = TextStyle(
  color: Colors.blueGrey,
  fontSize: 16.0,
  height: 1.1,
);

final mainColor = Color(0xFF24166b);
final secondaryColor = Color(0xFFffbc40);
final boxshadow = [
  BoxShadow(
      color: Colors.grey.shade500,
      offset: Offset(4, 4),
      blurRadius: 10,
      spreadRadius: 1.0),
  BoxShadow(
      color: Colors.white,
      offset: Offset(-4, -4),
      blurRadius: 10,
      spreadRadius: 1.0),
];
