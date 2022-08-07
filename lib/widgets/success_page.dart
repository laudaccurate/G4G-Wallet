import 'package:flutter/material.dart';
import 'package:gfg_wallet/screens/landing_page.dart';
import 'package:gfg_wallet/utils/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatefulWidget {
  final String message;
  final String name;
  final String amount;
  final String account;
  final String referenceId;
  final bool beneficary;
  final VoidCallback function;
  const SuccessPage({
    Key? key,
    required this.message,
    required this.name,
    required this.account,
    required this.beneficary,
    required this.function,
    required this.amount,
    required this.referenceId,
  }) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  bool save = false;
  saveBeneficiary() {
    setState(() {
      save = !save;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.share, color: Colors.green),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.green, Color.fromARGB(255, 1, 107, 56)],
          ),
        ),
        child: Column(children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LandingPage())),
                  icon: const Icon(Icons.close, color: Colors.white))
            ],
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              // width: MediaQuery.of(context).size.width * 0.4,
              child: Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_y2hxPc.json',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${widget.message} ',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 2,
            color: Colors.white24,
          ),
          Text(
            'Ref ID: ${widget.referenceId}',
            style: GoogleFonts.montserrat(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.white24,
          ),
          const SizedBox(height: 10),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text('${widget.name} '.toUpperCase(),
                    style: GoogleFonts.montserrat(
                      color: Colors.grey,
                      // fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                subtitle: Text('${widget.account} ',
                    style: GoogleFonts.montserrat(
                        color: Colors.black, letterSpacing: 1)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: saveBeneficiary,
                  icon: Icon(save ? Icons.star : Icons.star_border_outlined,
                      color: Colors.white, size: 30)),
              Text(
                'Add to beneficiaries',
                style: GoogleFonts.comfortaa(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const Divider(),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    // width: MediaQuery.of(context).size.width * 0.4,
                    child: Lottie.network(
                        'https://assets3.lottiefiles.com/private_files/lf30_ln2embei.json'),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        'Transfer amount',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        ' ${widget.amount}',
                        style: GoogleFonts.montserrat(
                            fontSize: 30, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Utilities.fullDateFormat(DateTime.now()),
                        style: GoogleFonts.montserrat(
                            fontSize: 12, color: Colors.white70),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.white,
                      ),
                      Text(
                        'Show transaction details',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }
}
