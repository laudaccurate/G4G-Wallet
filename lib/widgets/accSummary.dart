// @dart=2.9
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gfg_wallet/models.dart/accountModels.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/mockData.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:gfg_wallet/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class AccountSummary extends StatefulWidget {
  final AccountModelDatum data;
  final Function(AccountModelDatum) onAccountChange;
  const AccountSummary({
    @required this.data,
    this.onAccountChange,
  });

  @override
  State<AccountSummary> createState() => _AccountSummaryState();
}

class _AccountSummaryState extends State<AccountSummary> {
  AccountModelDatum account;

  @override
  void initState() {
    super.initState();
    account = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        Utilities.selectAccount(
          context: context,
          accounts: MockData.accounts,
          onAcctSelected: (acc) {
            setState(() {
              account = acc;
            });
            widget.onAccountChange(acc);
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: PhysicalModel(
          elevation: 10,
          borderRadius: BorderRadius.circular(10),
          color: themeProvider.themeData().backgroundColor,
          child: ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/bk3.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeProvider.isLightTheme
                      ? Constants.mainColor.withOpacity(0.3)
                      : themeProvider
                          .themeData()
                          .backgroundColor
                          .withOpacity(0.6),
                ),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       account.accountType,
                    //       style: TextStyle(
                    //         color: themeProvider.isLightTheme
                    //             ? Constants.secondaryColor
                    //             : Colors.white,
                    //       ),
                    //     ),
                    //     Text(
                    //       Utilities.accNum(account.accountNumber),
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         color: Constants.mainColor,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    _accountDetails(
                      account.accountType,
                      Utilities.accNum(account.accountNumber),
                      context,
                    ),
                    SizedBox(height: 15),
                    _accountDetails(
                      "Current Balance",
                      "${account.currency} ${Utilities.formatAmounts(account.availableBalance)}",
                      context,
                    ),
                    SizedBox(height: 3),
                    Divider(
                      color: themeProvider.isLightTheme
                          ? null
                          : Colors.white.withOpacity(0.6),
                    ),
                    InkWell(
                      onTap: () async {
                        await Share.share(
                          'Account Name: ${account.accountDesc}\nBank Name: Rokel Commercial Bank\nAccount Number: ${account.accountNumber}\nBank Branch: ${account.accountBranch}\nAccount Type: ${widget.data.accountType}\nCurrency: ${widget.data.currency}',
                          subject: 'Account Details',
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.ios_share,
                              size: 15,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Share account details",
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: 15),
                    // _accountDetails("Ledger Balance",
                    //     currency + " " + Utilities.formatAmounts(data.ledgerBalance)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

_accountDetails(String label, String data, BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          color: themeProvider.isLightTheme
              ? Constants.secondaryColor
              : Colors.white.withOpacity(0.7),
        ),
      ),
      Text(
        data,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: themeProvider.isLightTheme
              ? Constants.secondaryColor
              : Colors.white,
        ),
      ),
    ],
  );
}
