import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  final String? description;

  const NoData({Key? key, this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String image =
        'https://assets9.lottiefiles.com/private_files/lf30_rrpywigs.json';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Lottie.asset('assets/json/noData.json'),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              description ?? "No Data Found",
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
