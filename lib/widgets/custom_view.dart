import 'package:flutter/material.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:provider/provider.dart';

class CustomView extends StatelessWidget {
  final Widget widget;
  const CustomView({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bk3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            color: themeProvider.isLightTheme
                ? Colors.white.withOpacity(0.8)
                : themeProvider.themeData().backgroundColor.withOpacity(0.9),
            child: widget,
          )),
    );
  }
}
