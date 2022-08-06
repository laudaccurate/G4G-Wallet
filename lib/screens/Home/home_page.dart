// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_const_constructors, import_of_legacy_library_into_null_safe, avoid_unnecessary_containers, missing_required_param, missing_return, avoid_print
// @dart=2.9

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/screens/settingsScreen.dart';
import 'package:gfg_wallet/services/localStorage.dart';
import 'package:gfg_wallet/services/serviceLocator.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/retry.dart';
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
                            user.getUser.userAlias.toUpperCase(),
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
                            "G4G Wallet",
                            style: GoogleFonts.comfortaa(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Last login:${user.getUser.lastLogin}",
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
                children: user.getAccountList
                    .map(
                      (acc) => AccountWidget(account: acc),
                    )
                    .toList(),
                // children: [
                //   AccountWidget(account: user.getAccountList[0]),
                // ],
              ),
              // AccountWidget(account: user.getAccountList[0]),
              Align(
                alignment: Alignment(-1, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(
                    user.getAccountList,
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
                          : user.getAccountList.first.accountNumber;
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
                  'Menu',
                  style: GoogleFonts.comfortaa(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: MediaQuery.of(context).size.width * 0.07,
                  runSpacing: 20,
                  children: [
                    MenuOptions(
                      icon: CupertinoIcons.rocket,
                      color: Colors.teal,
                      function: () {},
                      display: transfers(context),
                      label: 'Transfers',
                    ),
                    MenuOptions(
                      icon: Icons.payment,
                      color: Colors.cyan,
                      function: () {},
                      label: 'Payments',
                      display: payment(context),
                    ),
                    MenuOptions(
                      icon: CupertinoIcons.layers_alt,
                      color: Colors.purpleAccent,
                      function: () {},
                      display: loans(context),
                      label: 'Loans',
                    ),
                    MenuOptions(
                      icon: CupertinoIcons.chart_bar,
                      color: Colors.redAccent,
                      function: () {},
                      display: investments(context),
                      label: 'Investments',
                    ),
                    MenuOptions(
                      icon: CupertinoIcons.rectangle_fill_on_rectangle_fill,
                      color: Colors.amber,
                      function: () {},
                      display: requests(context),
                      label: 'Requests',
                    ),
                    MenuOptions(
                      icon: Icons.people,
                      color: Colors.lightBlue,
                      function: () {},
                      display: beneficiaries(context),
                      label: 'Beneficiaries',
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
                    'Last Transactions',
                    style: GoogleFonts.comfortaa(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: toggleTransaction,
                    icon: Icon(
                      !showTransaction
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                    ),
                  )
                ],
              ),
              FutureBuilder<dynamic>(
                future: Future.delayed(Duration(seconds: 4), () {
                  print("future");
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return ShimmerLoader();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    // //print(snapshot.data);
                    if (snapshot.hasError) {
                      return CustomError(retry: () {
                        print("Retry---||");
                      });
                    } else if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        //print('snapshot is null');
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomNoData(message: "No transactions found"),
                          ],
                        );
                      } else if (snapshot.data.data.isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomNoData(message: "No transactions found"),
                          ],
                        );
                      } else {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 40),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TransactionDetail(
                                          data: snapshot.data.data[index],
                                          account:
                                              user.getAccountList[currentIndex],
                                        ),
                                      ),
                                    );
                                  },
                                  child: TransactionCard(
                                    data: snapshot.data.data[index],
                                    type: index % 3,
                                    visible: showTransaction,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                    } else {
                      return CustomError(retry: () {});
                    }
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
        label: 'Own Account',
        color: Colors.cyan,
        icon: Icons.person,
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
        label: 'Same Bank',
        color: Colors.orange,
        icon: Icons.people_alt,
        func: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Container(),
              ));
        },
      ),
      SettingTile(
        label: 'Other Bank(ACH)',
        color: Colors.purple,
        icon: Icons.bubble_chart,
        func: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Container(),
              ));
        },
      ),
      SettingTile(
        label: 'Salone Link',
        color: Colors.red,
        icon: Icons.account_balance,
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

  beneficiaries(context) {
    return Container();
  }

  investments(context) {
    return Container();
  }

  loans(context) {
    return Container();
  }

  requests(context) {
    return Column(children: [
      SettingTile(
        label: 'Statement Request',
        color: Colors.cyan,
        icon: Icons.receipt_long,
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
        label: 'Cheque Book Request',
        color: Colors.orange,
        icon: Icons.menu_book,
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
        label: 'Salary Advance',
        color: Colors.purple,
        icon: Icons.volunteer_activism,
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
        label: 'View Forex Rate',
        color: Colors.teal,
        icon: Icons.bar_chart,
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
        label: 'Stop Cheque',
        color: Colors.red,
        icon: Icons.block,
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
          label: 'Airtime Topup',
          color: Color(0XFF9c1d7c),
          icon: Icons.phone_iphone_rounded,
          func: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Container(),
                ));
          }),
      SettingTile(
        label: 'Account to Mobile Money',
        color: Colors.orange,
        icon: Icons.add_to_home_screen,
        func: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Container(),
              ));
        },
      ),
      SettingTile(
        label: 'Mobile Money to Account',
        color: Color.fromARGB(255, 240, 32, 129),
        icon: Icons.account_balance,
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
        label: 'Blink Pay',
        color: Colors.teal,
        icon: CupertinoIcons.arrowshape_turn_up_left_2,
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
        label: 'QR Payment',
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
        label: 'Utility Payment',
        color: Color(0XFF0c009b),
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
        label: 'School Payments',
        color: Colors.lightGreenAccent,
        icon: Icons.school,
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
    if (show) {
      return Utilities.formatAmounts(widget.account.availableBalance);
    } else {
      return '**********';
    }
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
                  builder: ((context) => Container()),
                ),
              )),
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
                                Text(Utilities.formatCardNo(
                                  widget.account.accountNumber,
                                )),
                              ],
                            ),
                            PhysicalModel(
                              elevation: 10,
                              color: themeProvider.themeData().backgroundColor,
                              shape: BoxShape.circle,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/slcb.png'),
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
                                  'Balance',
                                  style: GoogleFonts.comfortaa(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(height: 2.0),
                                Text(
                                  '${widget.account.currency} ${_amount()}',
                                  style: GoogleFonts.comfortaa(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: themeProvider.isLightTheme
                                        ? Constants.mainColor
                                        : Colors.tealAccent,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: toggleTransaction,
                              icon: Icon(
                                !show
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
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
