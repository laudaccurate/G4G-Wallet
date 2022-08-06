import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'noData.dart';

class CustomError extends StatelessWidget {
  final Function retry;
  const CustomError({
    required this.retry,
  });
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                // width: MediaQuery.of(context).size.width * 0.4,
                child: Lottie.asset('assets/json/error.json'),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'An Error Occured',
              style: GoogleFonts.comfortaa(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                print('********');
                retry();
              },
              child: const Text("Retry"),
            )
          ],
        ),
      ),
    );
  }
}

class CustomNoData extends StatelessWidget {
  final String message;

  const CustomNoData({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return NoData(description: message);
  }
}
