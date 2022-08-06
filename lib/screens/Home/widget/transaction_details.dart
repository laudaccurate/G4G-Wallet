// @dart=2.9

import 'package:flutter/material.dart';
import 'package:gfg_wallet/models.dart/accountModels.dart';
import 'package:gfg_wallet/models.dart/transHistoryModel.dart';
import 'package:gfg_wallet/provider/globals.dart';
import 'package:gfg_wallet/screens/receipt/receipt_view.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:gfg_wallet/utils/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TransactionDetail extends StatefulWidget {
  final TransHistoryDatum data;
  final AccountModelDatum account;
  const TransactionDetail(
      {Key key, @required this.data, @required this.account})
      : super(key: key);

  @override
  _TransactionDetailState createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final def = Provider.of<Globals>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await generatePDF();
        },
        child: const Icon(Icons.receipt),
      ),
      /*  OpenContainer(
        closedElevation: 10,
        transitionDuration: Duration(milliseconds: 500),
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        closedColor: themeProvider.themeData().backgroundColor,
        openColor: themeProvider.themeData().backgroundColor,
        closedBuilder: (context, openBuilder) {
          return FloatingActionButton(
            backgroundColor:
                themeProvider.isLightTheme ? Constants.mainColor : Colors.white,
            child: Container(
              child: Icon(
                CupertinoIcons.doc_text,
                color: !themeProvider.isLightTheme
                    ? Constants.mainColor
                    : Colors.white,
                size: 28,
              ),
            ),
            onPressed: null,
          );
        },
        openBuilder: (context, closeBuilder) {
          return writeOnPdf();
          // ReceiptView();
        },
      ),*/
      body: Stack(children: [
        Container(
          height: size.height * 0.5,
          decoration:
              BoxDecoration(color: Constants.mainColor.withOpacity(0.6)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: PhysicalModel(
              elevation: 30,
              borderRadius: BorderRadius.circular(8),
              color: themeProvider.themeData().backgroundColor,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: size.height * 0.8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeProvider.themeData().backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.08),
                      // Text(
                      //   "Activity Details",
                      //   style: GoogleFonts.comfortaa(
                      //     fontSize: 20,
                      //   ),
                      // ),
                      // const SizedBox(height: 5),
                      Center(
                        child: Text(
                          widget.data.narration,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.comfortaa(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Center(
                        child: Text(
                          Utilities.fullDateFormat(widget.data.postingSysDate),
                          style: GoogleFonts.comfortaa(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Divider(),
                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _label("Amount"),
                              const SizedBox(height: 8),
                              Text(
                                "${widget.account.currency} ${Utilities.formatAmounts(widget.data.amount)}",
                                style: GoogleFonts.crimsonPro(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.green,
                              ),
                            ),
                            child: Text(
                              'Success',
                              style: GoogleFonts.comfortaa(
                                  color: Colors.green, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      _label("Paid into"),

                      const SizedBox(height: 8),
                      _value(widget.data.contraAccount),

                      const Spacer(),

                      _label("Originated From"),

                      const SizedBox(height: 8),

                      _value(widget.data.channel),

                      const Spacer(),

                      _label("Reference Number"),
                      const SizedBox(height: 8),

                      _value(widget.data.documentReference),
                      const Spacer(),

                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Constants.mainColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/slcb.png'),
                          ),
                          title: Text(widget.account.accountType),
                          subtitle: Text(widget.account.accountNumber),
                        ),
                      ),

                      const Spacer(),
                      if (widget.data.imageCheck == 0) ...[
                        def.getLoading
                            ? const LinearProgressIndicator()
                            : Container(
                                padding: const EdgeInsets.all(5.0),
                                margin: const EdgeInsets.only(bottom: 15.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Constants.mainColor),
                                    // color: Constants.mainColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      // await AccountController.getVoucher(
                                      //     context: context,
                                      //     batchNumber: widget.data.batchNumber);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.receipt_long_rounded,
                                          color: Constants.mainColor,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "VIEW VOUCHER",
                                          style: TextStyle(
                                            color: Constants.mainColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                      ],
                    ]),
              ),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.74),
          child: Container(
            padding: const EdgeInsets.all(9.0),
            decoration: BoxDecoration(
              color: themeProvider.themeData().backgroundColor,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
                backgroundColor: Colors.green,
                maxRadius: size.width * 0.13,
                child: Icon(
                  Icons.check_rounded,
                  color: themeProvider.themeData().backgroundColor,
                  size: size.width * 0.2,
                )),
          ),
        ),
        Align(
          alignment: const Alignment(0.9, -0.9),
          child: InkWell(
            onTap: (() => Navigator.pop(context)),
            child: Icon(
              Icons.cancel_rounded,
              color: themeProvider.themeData().backgroundColor,
              size: 35,
            ),
          ),
        ),
      ]),
    );
  }
}

_label(String text) {
  return Text(
    text,
    style: GoogleFonts.comfortaa(
      fontSize: 12,
      color: Colors.grey,
    ),
  );
}

_value(String text) {
  return Text(
    text,
    style: GoogleFonts.comfortaa(
      fontSize: 15,
      color: Colors.grey,
      fontWeight: FontWeight.bold,
    ),
  );
}
