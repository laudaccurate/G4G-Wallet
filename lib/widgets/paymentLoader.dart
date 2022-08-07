// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/globals.dart';

class PaymentLoader extends StatelessWidget {
  final Widget widget;
  const PaymentLoader({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final def = Provider.of<Globals>(context);

    return Scaffold(
      body: Stack(
        children: [
          widget,
          if (def.getLoading) ...[
            Container(
              color: Colors.white.withOpacity(0.7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.36,
                      // width: MediaQuery.of(context).size.width * 0.4,
                      child: Lottie.network(
                        'https://assets8.lottiefiles.com/packages/lf20_x8loe47i.json',
                      ),
                    ),
                  ),
                  Center(
                    child: DefaultTextStyle(
                      style: GoogleFonts.comfortaa(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0XFFBB3F3F)),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(def.getLoaderMessage,
                              speed: const Duration(milliseconds: 200)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ],
      ),
    );
  }
}
