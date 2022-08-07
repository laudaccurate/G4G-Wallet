// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gfg_wallet/models.dart/transHistoryModel.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:gfg_wallet/utils/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  final TransHistoryDatum data;

  final bool visible;
  final int type;
  const TransactionCard({
    Key key,
    @required this.visible,
    @required this.type,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        PhysicalModel(
          elevation: 10,
          shape: BoxShape.circle,
          color: themeProvider.themeData().backgroundColor,
          child: Container(
              decoration: BoxDecoration(
                // boxShadow: themeProvider.themeMode().shadow,
                borderRadius: BorderRadius.circular(7),
                color: themeProvider.themeData().backgroundColor,
              ),
              padding: const EdgeInsets.all(8),
              child: _transactions(type)
              // const Icon(
              //   Icons.bubble_chart,
              //   size: 20,
              //   color: Colors.lightBlue,
              // ),
              ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.narration,
                style: GoogleFonts.comfortaa(
                  fontSize: 13,
                  color: themeProvider.isLightTheme
                      ? Colors.black54
                      : Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                Utilities.fullDateFormat(data.valueDate),
                style: GoogleFonts.montserrat(
                  fontSize: 9,
                  color:
                      themeProvider.isLightTheme ? Colors.grey : Colors.white30,
                ),
              ),
            ],
          ),
        ),
        Text(
          "${Constants.currency} ${Utilities.formatAmounts(data.amount)}",
          style: GoogleFonts.comfortaa(
            fontSize: 14,
            color: double.parse(data.amount) < 0
                ? Colors.red
                : Colors.green.shade600,
          ),
        ),
      ]),
    );
  }
}

_transactions(int type) {
//transfers === 1
  switch (type) {
    case 0:
      return const Icon(CupertinoIcons.rocket, color: Colors.teal);

    case 1:
      return const Icon(CupertinoIcons.creditcard, color: Colors.red);

    case 2:
      return const Icon(CupertinoIcons.chart_bar, color: Colors.amber);

    case 3:
      return const Icon(CupertinoIcons.rocket, color: Colors.teal);

    case 4:
      return const Icon(CupertinoIcons.rocket, color: Colors.teal);

    default:
      return const Icon(CupertinoIcons.rocket, color: Colors.teal);
  }
}
