// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, import_of_legacy_library_into_null_safe, avoid_unnecessary_containers, missing_required_param, missing_return, avoid_print
// @dart=2.9

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gfg_wallet/models.dart/transHistoryModel.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/screens/Payments/wallet.dart';
import 'package:gfg_wallet/screens/settingsScreen.dart';
import 'package:gfg_wallet/screens/transHistory.dart';
import 'package:gfg_wallet/services/localStorage.dart';
import 'package:gfg_wallet/services/serviceLocator.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/mockData.dart';
import 'package:gfg_wallet/utils/shimmerLoader.dart';
import 'package:gfg_wallet/utils/util.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../models.dart/accountModels.dart';
import '../../utils/themes.dart';
import 'widget/menu_option.dart';
import 'widget/transaction_card.dart';
import 'widget/transaction_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LocalStorageService storageService = locator<LocalStorageService>();
  bool showTransaction = false;
  toggleTransaction() {
    setState(() {
      showTransaction = !showTransaction;
    });
  }

  int currentIndex = 0;
  String startDate = "";
  String endDate = "";
  String accNum;
  bool reload = false;
  int selectedAcc = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(padding: EdgeInsets.zero, children: [
        SizedBox(
          height: size.height * 0.4,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: size.height * 0.26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  color: Constants.mainColor,
                ),
                child: Column(children: [
                  SizedBox(height: size.height * 0.06),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://source.unsplash.com/random/200x200?sig=1'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Utilities.greetingMessage().toUpperCase(),
                            style: GoogleFonts.comfortaa(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 9),
                          Text(
                            // user.getUser.userAlias.toUpperCase(),
                            'LAUD GILBERT',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.comfortaa(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "G4G Wallet (Premium)",
                            style: GoogleFonts.comfortaa(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Last login:${Utilities.fullDateFormat(DateTime.now())}",
                            style: GoogleFonts.comfortaa(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
              PageView(
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: MockData.accounts
                    .map(
                      (acc) => AccountWidget(account: acc),
                    )
                    .toList(),
                // children: [
                //   AccountWidget(account: MockData.accounts[0]),
                // ],
              ),
              // AccountWidget(account: MockData.accounts[0]),
              Align(
                alignment: Alignment(-1, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(
                    MockData.accounts,
                    (index, acc) {
                      return Container(
                        width: 6.5,
                        height: 6.0,
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Constants.mainColor,
                          ),
                          shape: BoxShape.circle,
                          color: currentIndex == index
                              ? Constants.mainColor
                              : Colors.transparent,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment(1, -0.53),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    bottom: 8,
                  ),
                  child: InkWell(
                    onTap: () {
                      String debitAccNum = '';
                      debitAccNum = storageService.defaultAccount != ''
                          ? jsonDecode(
                              storageService.defaultAccount)["accountNumber"]
                          : MockData.accounts.first.accountNumber;
                      var data = {
                        "accountNumber": debitAccNum,
                        "amount": "0",
                      };
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Center(
                                  //   child: QrImage(
                                  //     data: jsonEncode(data),
                                  //     version: QrVersions.auto,
                                  //     size: 280,
                                  //     padding: EdgeInsets.all(20),
                                  //     gapless: false,
                                  //     embeddedImage:
                                  //         AssetImage(Constants.logoImage),
                                  //     embeddedImageStyle: QrEmbeddedImageStyle(
                                  //       size: Size(60, 40),
                                  //     ),
                                  //   ),
                                  // ),
                                  Text(
                                    debitAccNum,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                    child: PhysicalModel(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Icon(
                          FontAwesomeIcons.qrcode,
                          size: size.width * 0.08,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 5.0),
            ],
          ),
        ),
        Container(
          // height: size.height * 0.3,
          padding: EdgeInsets.all(15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Features',
                  style: GoogleFonts.comfortaa(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MenuOptions(
                      icon: CupertinoIcons.paperplane,
                      color: Colors.teal,
                      function: () {},
                      display: transfers(context),
                      label: 'Transfer',
                    ),
                    MenuOptions(
                      icon: Icons.account_balance_wallet_outlined,
                      color: Colors.cyan,
                      function: () {},
                      label: 'Payments',
                      display: payment(context),
                    ),
                    MenuOptions(
                      icon: CupertinoIcons.qrcode_viewfinder,
                      color: Colors.purpleAccent,
                      function: () {},
                      display: requests(context),
                      label: 'QR Pay',
                    ),
                    MenuOptions(
                      icon: CupertinoIcons.cart_badge_plus,
                      color: Colors.redAccent,
                      function: () {},
                      display: investments(context),
                      label: 'Voucher',
                    ),
                  ],
                )
              ]),
        ),
        Container(
          padding: EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.7,
          // color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions',
                    style: GoogleFonts.comfortaa(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: toggleTransaction,
                    icon: Icon(CupertinoIcons.slider_horizontal_3),
                  )
                ],
              ),
              FutureBuilder<List<TransHistoryDatum>>(
                future: Future.delayed(Duration(seconds: 2), () {
                  print("future");

                  return MockData.transactions;
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return ShimmerLoader();
                  } else {
                    var trans = MockData.transactions;

                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: trans.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TransactionDetail(
                                      data: trans[index],
                                      account: MockData.accounts[currentIndex],
                                    ),
                                  ),
                                );
                              },
                              child: TransactionCard(
                                data: trans[index],
                                type: index % 3,
                                visible: showTransaction,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        )
      ]),
    );
  }

  transfers(context) {
    return Column(children: [
      SettingTile(
        label: 'Mobile Transfer',
        color: Colors.cyan,
        icon: Icons.mobile_screen_share_rounded,
        func: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Container(),
            ),
          );
        },
      ),
      SettingTile(
        label: 'Bank Transfer',
        color: Colors.purple,
        icon: Icons.account_balance_rounded,
        func: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Container(),
              ));
        },
      ),
      SettingTile(
        label: 'International Transfer',
        color: Colors.red,
        icon: CupertinoIcons.globe,
        func: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Container(),
              ));
        },
      ),
    ]);
  }

  investments(context) {
    return Container();
  }

  requests(context) {
    return Column(children: [
      SettingTile(
        label: 'Pay With QR',
        color: Colors.lightBlueAccent,
        icon: CupertinoIcons.qrcode_viewfinder,
        func: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Container(),
            ),
          );
        },
      ),
      SettingTile(
        label: 'Receive from QR',
        color: Colors.cyan,
        icon: Icons.qr_code_scanner_rounded,
        func: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Container(),
            ),
          );
        },
      ),
    ]);
  }

  payment(context) {
    return Column(children: [
      SettingTile(
        label: 'Pay from Wallet',
        color: Colors.orange,
        icon: Icons.account_balance_wallet_rounded,
        func: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WalletPayment(),
              ));
        },
      ),
      SettingTile(
        label: 'Pay With PIN',
        color: Color.fromARGB(255, 240, 32, 129),
        icon: Icons.password_rounded,
        func: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Container(),
            ),
          );
        },
      ),
      SettingTile(
        label: 'Utility Payment',
        color: Colors.teal,
        icon: Icons.electrical_services_rounded,
        func: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Container(),
            ),
          );
        },
      ),
      SettingTile(
        label: 'Airtime Topup',
        color: Color(0XFF0c009b),
        icon: Icons.phone_iphone_outlined,
        func: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Container(),
            ),
          );
        },
      ),
    ]);
  }
}

class AccountWidget extends StatefulWidget {
  final AccountModelDatum account;
  const AccountWidget({Key key, @required this.account}) : super(key: key);

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  bool show = false;
  String _amount() {
    return Utilities.formatAmounts(widget.account.availableBalance);
  }

  toggleTransaction() {
    setState(() {
      show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: const Alignment(-1, 1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => TransHistory(
                        data: widget.account,
                        showBack: true,
                      ))))),
          child: PhysicalModel(
            elevation: 10,
            borderRadius: BorderRadius.circular(8),
            color: themeProvider.themeData().backgroundColor,
            child: ClipRRect(
              child: Container(
                height: size.height * 0.2,
                // width: size.width * 0.9,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/bk3.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: themeProvider
                        .themeData()
                        .backgroundColor
                        .withOpacity(0.6),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.account.accountType,
                                  style: TextStyle(
                                    color: themeProvider.themeMode().textColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(widget.account.accountDesc.toUpperCase()),
                                SizedBox(height: 5),
                                Text(
                                  Utilities.formatCardNo(
                                    widget.account.accountNumber,
                                  ),
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            PhysicalModel(
                              elevation: 10,
                              color: themeProvider.themeData().backgroundColor,
                              shape: BoxShape.circle,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/logo.png'),
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Available Balance',
                                  style: GoogleFonts.comfortaa(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  '${widget.account.currency} ${_amount()}',
                                  style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Constants.mainColor),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: toggleTransaction,
                              icon: Icon(
                                FontAwesomeIcons.ccVisa,
                              ),
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
