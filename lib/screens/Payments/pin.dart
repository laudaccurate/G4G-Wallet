// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:gfg_wallet/controllers/AuthController.dart';
import 'package:gfg_wallet/models.dart/accountModels.dart';
import 'package:gfg_wallet/services/contacts.dart';
import 'package:gfg_wallet/services/localStorage.dart';
import 'package:gfg_wallet/services/serviceLocator.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/mockData.dart';
import 'package:gfg_wallet/widgets/appBar.dart';
import 'package:gfg_wallet/widgets/custom_view.dart';
import 'package:gfg_wallet/widgets/infoCard.dart';
import 'package:gfg_wallet/widgets/inputFields.dart';
import 'package:gfg_wallet/widgets/paymentLoader.dart';
import 'package:gfg_wallet/widgets/success_page.dart';
import '../../utils/util.dart';
import '../../widgets/enter_pin_secAnswer.dart';

class PinPayment extends StatefulWidget {
  const PinPayment({Key? key}) : super(key: key);

  @override
  _PinPaymentState createState() => _PinPaymentState();
}

class _PinPaymentState extends State<PinPayment> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController invoiceId = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController reference = TextEditingController();
  TextEditingController narration = TextEditingController();

  String amount = "";
  String name = "";

  AccountModelDatum? debitAccount = MockData.accounts.first;
  @override
  Widget build(BuildContext context) {
    LocalStorageService storageService = locator<LocalStorageService>();

    return PaymentLoader(
      widget: Scaffold(
        appBar: customAppBar('Payment From Wallet', context),
        body: SingleChildScrollView(
          child: CustomView(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Constants.spacer,
                const InfoCard(
                  info:
                      'Dear Valued Customer, please ensure that the receiver`s number is correct as G4G will not be liable if you transfer to wrong number',
                ),
                Constants.spacer,
                const Label('Phone Number'),
                Row(children: [
                  Expanded(
                    child: CustomTextInput(
                      label: 'Phone Number',
                      controller: phoneNumber,
                      keyboard: TextInputType.number,
                      suffix: Icon(
                        Icons.contacts,
                        size: 20.0,
                        color: Colors.grey[500],
                      ),
                      onEdited: (val) async {},
                    ),
                  ),
                  const SizedBox(width: 5),
                  PhysicalModel(
                    elevation: 10,
                    color: Constants.mainColor,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Constants.mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: IconButton(
                        onPressed: () async {
                          var number = await ContactsPicker().fetchContact();
                          if (number != null) {
                            phoneNumber.text = Utilities.phoneNumber(
                                (number as PhoneContact).phoneNumber!);
                            name = number.fullName!;
                          } else {}
                        },
                        icon: const Icon(
                          Icons.contacts,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ]),
                Constants.spacer,
                const Label('Amount'),
                AmountFeild(
                    currency: "NGN",
                    onEdited: (val) {
                      setState(() {
                        amount = val.toString();
                      });
                    }),
                Constants.spacer,
                const Label('Invoice ID'),
                CustomTextInput(
                  label: 'Invoice ID',
                  controller: invoiceId,
                  suffix: Icon(
                    Icons.receipt,
                    size: 20.0,
                    color: Colors.grey[500],
                  ),
                  onEdited: (val) {},
                ),
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
                        'Transfer From': debitAccount?.accountNumber,
                        'Phone Number': phoneNumber.text,
                        'Invoice ID': invoiceId.text,
                        'Reference': reference.text,
                        'Amount': MockData.accounts.first.currency +
                            ' ' +
                            Utilities.formatAmounts(amount),
                        'Narration': narration.text,
                        // 'Fee': Utilities.formatAmounts('10'),
                      },
                      amount: amount,
                      onSubmit: () async {
                        // var token = storageService.user != null
                        //     ? jsonDecode(storageService.user)["token"]
                        //     : MockData.token;
                        var res = await AuthController.payWithPin(context, {
                          "channel_code": "APISNG",
                          "phone_number": phoneNumber.text,
                          "amount": amount,
                          "reference": reference.text,
                          "transaction_pin": pinController.text,
                          "invoice_id": invoiceId.text,
                          "product_code": "001",
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
