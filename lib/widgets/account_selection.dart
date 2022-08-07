// @dart=2.9

import 'package:flutter/material.dart';
import 'package:gfg_wallet/models.dart/accountModels.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/utils/mockData.dart';
import 'package:gfg_wallet/utils/util.dart';
import 'package:gfg_wallet/widgets/account_widget.dart';
import 'package:provider/provider.dart';

class AccountSelection extends StatefulWidget {
  final Function(AccountModelDatum) selectedAccount;

  const AccountSelection({Key key, @required this.selectedAccount})
      : super(key: key);
  @override
  _AccountSelectionState createState() => _AccountSelectionState();
}

class _AccountSelectionState extends State<AccountSelection> {
  int selectedAcc;
  AccountModelDatum debitAccount;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () {
        Utilities.selectAccount(
          context: context,
          accounts: MockData.accounts,
          selectedAcc: selectedAcc,
          onAcctSelected: (acc) {
            setState(() {
              selectedAcc = MockData.accounts.indexOf(acc);
              debitAccount = acc;
              widget.selectedAccount(debitAccount);
            });
          },
        );
      },
      child: AccountSelectWidget(
        account: debitAccount,
      ),
    );
  }
}
