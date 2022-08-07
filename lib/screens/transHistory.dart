// @dart=2.9
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gfg_wallet/models.dart/accountModels.dart';
import 'package:gfg_wallet/models.dart/transHistoryModel.dart';
import 'package:gfg_wallet/screens/Home/widget/transaction_card.dart';
import 'package:gfg_wallet/screens/Home/widget/transaction_details.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/mockData.dart';
import 'package:gfg_wallet/utils/shimmerLoader.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:gfg_wallet/widgets/accSummary.dart';
import 'package:gfg_wallet/widgets/customProgress.dart';
import 'package:gfg_wallet/widgets/enter_pin_secAnswer.dart';
import 'package:provider/provider.dart';

class TransHistory extends StatefulWidget {
  final bool showBack;
  final AccountModelDatum data;
  TransHistory({
    Key key,
    @required this.data,
    this.showBack,
  }) : super(key: key);

  @override
  _TransHistoryState createState() => _TransHistoryState();
}

class _TransHistoryState extends State<TransHistory> {
  List<TransHistoryDatum> _data = MockData.transactions;
  List<TransHistoryDatum> _filter;
  String startDate = "";
  String endDate = "";
  String type = "All";
  List<StepperModel> data = [
    StepperModel(color: Colors.red, name: "Debit"),
    StepperModel(color: Colors.green, name: "Credit"),
    StepperModel(color: Colors.amber, name: "All"),
  ];

  double _height;

  bool reload = false;

  Future<void> _refresh() async {
    //print("__refreshing");
    setState(() {
      reload = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        floatingActionButton: _data == null
            ? SizedBox()
            : _data.isEmpty
                ? SizedBox()
                : FloatingActionButton.extended(
                    tooltip: 'download',
                    backgroundColor: Colors.green,
                    onPressed: () {
                      // createPDF(
                      //   acctData: widget.data,
                      //   data: _data,
                      //   name: widget.data.accountDesc,
                      // );
                    },
                    label: Row(
                      children: [
                        Icon(
                          Icons.file_download,
                          color: Colors.white,
                        ),
                        // SizedBox(width: 5),
                        // Text(
                        //   "Pay Again",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    )),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: _height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                      opacity: widget.showBack ? 1 : 0,
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: themeProvider.isLightTheme
                                ? Constants.secondaryColor
                                : Colors.white,
                          ),
                          onPressed: () =>
                              widget.showBack ? Navigator.pop(context) : null),
                    ),
                    Text(
                      "Transaction History",
                      style: TextStyle(
                          color: themeProvider.isLightTheme
                              ? Constants.secondaryColor
                              : Colors.white,
                          fontSize: 16.0),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.date_range,
                        color: themeProvider.isLightTheme
                            ? Constants.mainColor
                            : Colors.white,
                      ),
                      onPressed: () async {
                        DateTimeRange date;
                        final DateTimeRange picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(1990),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null && picked != date) {
                          setState(() {
                            date = picked;
                            //print(_date.toString());

                            reload = true;

                            // reload = false;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
              AccountSummary(
                data: widget.data,
                onAccountChange: (acc) {
                  setState(() {});
                },
              ),
              // Container(
              //   margin: EdgeInsets.all(20),
              //   height: 35,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(color: Colors.grey),
              //   ),
              // ),
              CustomProgress(
                width: MediaQuery.of(context).size.width * 0.9,
                stepperData: data,
                selected: type,
                onTap: (val) {
                  //print(val);
                  if (_data != null) {
                    setState(() {
                      type = val;
                      if (val == "Debit") {
                        _filter = _data
                            .where((e) => double.parse(e.amount) < 0)
                            .toList();
                      } else if (val == "Credit") {
                        _filter = _data
                            .where((e) => double.parse(e.amount) > 0)
                            .toList();
                      } else {
                        _filter = _data;
                      }
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DescriptionTitle(
                  description: "Transaction History",
                ),
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
                    _data = MockData.transactions;
                    _filter = _filter ?? _data;
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: RefreshIndicator(
                          onRefresh: () => _refresh(),
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: _filter.length,
                            separatorBuilder: (context, inndex) {
                              return Divider();
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TransactionDetail(
                                        data: _filter[index],
                                        account: widget.data,
                                      ),
                                    ),
                                  );
                                },
                                child: TransactionCard(
                                  data: _filter[index],
                                  type: index % 3,
                                  visible: true,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
