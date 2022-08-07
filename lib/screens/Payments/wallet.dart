// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gfg_wallet/controllers/AuthController.dart';
import 'package:gfg_wallet/models.dart/accountModels.dart';
import 'package:gfg_wallet/provider/phoneDetails.dart';
import 'package:gfg_wallet/provider/userProvider.dart';
import 'package:gfg_wallet/services/localStorage.dart';
import 'package:gfg_wallet/services/serviceLocator.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/mockData.dart';
import 'package:gfg_wallet/widgets/appBar.dart';
import 'package:gfg_wallet/widgets/custom_view.dart';
import 'package:gfg_wallet/widgets/inputFields.dart';
import 'package:gfg_wallet/widgets/paymentLoader.dart';
import 'package:gfg_wallet/widgets/success_page.dart';
import 'package:provider/provider.dart';
import '../../utils/util.dart';
import '../../widgets/enter_pin_secAnswer.dart';

class WalletPayment extends StatefulWidget {
  const WalletPayment({Key? key}) : super(key: key);

  @override
  _WalletPaymentState createState() => _WalletPaymentState();
}

class _WalletPaymentState extends State<WalletPayment> {
  TextEditingController userEmail = TextEditingController();
  TextEditingController receiverName = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController reference = TextEditingController();
  TextEditingController narration = TextEditingController();

  String amount = "";
  String name = "";

  AccountModelDatum? debitAccount;
  @override
  Widget build(BuildContext context) {
    LocalStorageService storageService = locator<LocalStorageService>();
    final user = Provider.of<UserProvider>(context);
    final phoneInfo = Provider.of<PhoneInfo>(context, listen: false);
    return PaymentLoader(
      widget: Scaffold(
        appBar: customAppBar('Payment From Wallet', context),
        body: SingleChildScrollView(
          child: CustomView(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Constants.spacer,
                // const InfoCard(
                //   info:
                //       'Dear Valued Customer, please ensure that the receiver`s number is correct as SLCB will not be liable if you transfer to wrong number',
                // ),
                Constants.spacer,
                // const Label('Pay From'),
                // AccountSelection(
                //   selectedAccount: (data) {
                //     setState(() {
                //       debitAccount = data;
                //     });
                //   },
                // ),
                // Constants.spacer,
                // const Label('Phone Number'),
                // Row(children: [
                //   Expanded(
                //     child: CustomTextInput(
                //       label: 'Phone Number',
                //       controller: reference,
                //       keyboard: TextInputType.number,
                //       suffix: Icon(
                //         Icons.contacts,
                //         size: 20.0,
                //         color: Colors.grey[500],
                //       ),
                //       onEdited: (val) async {},
                //     ),
                //   ),
                //   const SizedBox(width: 5),
                //   PhysicalModel(
                //     elevation: 10,
                //     color: Colors.red,
                //     borderRadius: BorderRadius.circular(5),
                //     child: Container(
                //       decoration: BoxDecoration(
                //           color: Constants.mainColor,
                //           borderRadius: BorderRadius.circular(5)),
                //       child: IconButton(
                //         onPressed: () async {
                //           var number = await ContactsPicker().fetchContact();
                //           if (number != null) {
                //             reference.text = Utilities.phoneNumber(
                //                 (number as PhoneContact).phoneNumber!);
                //             name = number.fullName!;
                //           } else {}
                //         },
                //         icon: const Icon(
                //           Icons.contacts,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   )
                // ]),
                const Label('User Email'),
                CustomTextInput(
                  label: 'User Email',
                  controller: userEmail,
                  suffix: Icon(
                    Icons.mail,
                    size: 20.0,
                    color: Colors.grey[500],
                  ),
                  onEdited: (val) {},
                ),
                Constants.spacer,

                const Label('Recipient Alias'),
                CustomTextInput(
                  label: 'Recipient Alias',
                  controller: receiverName,
                  suffix: Icon(
                    Icons.person,
                    size: 20.0,
                    color: Colors.grey[500],
                  ),
                  onEdited: (val) {},
                ),
                Constants.spacer,
                const Label('Amount'),
                AmountFeild(
                    currency: debitAccount?.currency,
                    onEdited: (val) {
                      setState(() {
                        amount = val.toString();
                      });
                    }),
                Constants.spacer,
                const Label('Reference'),
                CustomTextInput(
                  label: 'Reference',
                  controller: reference,
                  suffix: Icon(
                    Icons.numbers_rounded,
                    size: 20.0,
                    color: Colors.grey[500],
                  ),
                  onEdited: (val) {},
                ),
                Constants.spacer,
                const Label('Narration'),
                CustomTextInput(
                  label: 'Narration',
                  controller: narration,
                  suffix: Icon(
                    Icons.numbers_rounded,
                    size: 20.0,
                    color: Colors.grey[500],
                  ),
                  onEdited: (val) {},
                ),
                Constants.spacer,
                Constants.spacer,
                CustomButton(
                  isActive: true,
                  label: 'Submit',
                  onPressed: () async {
                    await confirmationScreen(
                      context: context,
                      pinController: pinController,
                      data: {
                        'Transfer From': MockData.accounts.first.accountNumber,
                        'User Email': userEmail.text,
                        'Receiver Name': receiverName.text,
                        'Reference': reference.text,
                        'Amount': MockData.accounts.first.currency +
                            ' ' +
                            Utilities.formatAmounts(amount),
                        'Narration': narration.text,
                        // 'Fee': Utilities.formatAmounts('10'),
                      },
                      amount: amount,
                      onSubmit: () async {
                        var res = await AuthController.payFromWallet(context, {
                          "channel_code": "APISNG",
                          "user_email": userEmail.text,
                          "user_token":
                              jsonDecode(storageService.user)["token"],
                          "user_type": "USER",
                          "destination_wallet_alias": receiverName.text,
                          "amount": amount,
                          "reference": reference.text,
                          "narration": narration.text,
                          "tin": "003457832"
                        });

                        if (res != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessPage(
                                amount: debitAccount!.currency +
                                    ' ' +
                                    Utilities.formatAmounts(res.data.amount),
                                account: reference.text,
                                name: "",
                                beneficary: false,
                                function: () {},
                                referenceId: res.data.documentRef,
                                message: res.message,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                Constants.spacer,
                Constants.spacer
              ],
            ),
          ),
        ),
      ),
    );
  }
}
