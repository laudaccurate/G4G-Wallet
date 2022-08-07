// @dart=2.9

// ignore_for_file: file_names, prefer_const_constructors, prefer_typing_uninitialized_variables, must_be_immutable, unnecessary_null_in_if_null_operators, prefer_if_null_operators, prefer_void_to_null, prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gfg_wallet/provider/globals.dart';
import 'package:gfg_wallet/utils/constants.dart';
import 'package:gfg_wallet/utils/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class CustomTextArea extends StatefulWidget {
  final TextEditingController controller;
  final onEdited;
  final String label;
  final int maxLines;
  final TextInputType textInputType;

  const CustomTextArea(
      {Key key,
      this.controller,
      this.label,
      this.onEdited,
      this.maxLines,
      this.textInputType})
      : super(key: key);
  @override
  _CustomTextAreaState createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  final FocusNode focusNode = FocusNode();
  bool isValueValid = false;
  String value = '';

  @override
  void initState() {
    super.initState();
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          if (isValueValid) {
            //print('something');
            widget.onEdited(widget.controller.text.trim().trim());
          } else {
            //print('nothing');
            return;
          }
        } else {
          if (widget.controller.text.trim().trim().isNotEmpty || isValueValid) {
            //print('something');
            widget.onEdited(widget.controller.text.trim().trim());
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final _height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return PhysicalModel(
      elevation: 1.5,
      borderRadius: BorderRadius.circular(5.0),
      color: themeProvider.isLightTheme
          ? Colors.white
          : Colors.white.withOpacity(0.1),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextField(
          focusNode: focusNode,
          maxLines: widget.maxLines,
          keyboardType: widget.textInputType ?? TextInputType.text,
          controller: widget.controller,
          textAlign: TextAlign.start,
          onChanged: (val) {
            widget.onEdited(val.trim());
          },
          textAlignVertical: TextAlignVertical.top,
          style: GoogleFonts.comfortaa(
            color: themeProvider.isLightTheme
                ? Colors.grey[700]
                : Colors.grey[300],
            fontSize: 15.0,
          ),
          decoration: InputDecoration(
            // labelText: 'Enter Message',
            hintText: widget.label ?? 'Enter Message',
            hintStyle: GoogleFonts.comfortaa(
              color: Colors.grey[500],
              fontSize: 15.0,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class AmountFeild extends StatefulWidget {
  final Function(String) onEdited;
  final String currency;
  final FocusNode node;

  AmountFeild({
    Key key,
    @required this.onEdited,
    @required this.currency,
    this.node,
  }) : super(key: key);

  @override
  _AmountFeildState createState() => _AmountFeildState();
}

class _AmountFeildState extends State<AmountFeild> {
  final controller =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return PhysicalModel(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(5.0),
        color: themeProvider.isLightTheme
            ? Colors.white
            : Colors.white.withOpacity(0.1),
        child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 14.5),
                  decoration: BoxDecoration(
                    color: Constants.mainColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    widget.currency == null
                        ? 'SLL'
                        : widget.currency.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        letterSpacing: 1.5),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    focusNode: widget.node,
                    keyboardType: TextInputType.number,
                    controller: controller,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: themeProvider.isLightTheme
                            ? Colors.grey[700]
                            : Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 1.5),
                    onChanged: (string) {
                      //print(string);

                      widget.onEdited(string.replaceAll(',', ''));
                    },
                    // onEditingComplete: widget.onEdited(),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15.0,
                      ),
                      suffixIcon: Icon(
                        Icons.money,
                        size: 20.0,
                        color: Colors.grey[500],
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            )));
  }
}

class ContactChip extends StatelessWidget {
  const ContactChip({
    Key key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon ?? Icons.mail,
              size: 14,
              color: Colors.blue,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              text ?? '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomSearchBar({Key key, this.label, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return PhysicalModel(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.grey[100],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Constants.mainColor),
            SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: controller,
                textAlign: TextAlign.start,
                // textAlignVertical: TextAlignVertical.top,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15.0,
                ),
                onChanged: (val) {
                  //print(controller.text.trim());
                },
                decoration: InputDecoration(
                  // labelText: 'Enter Message',
                  hintText: label ?? 'Search ...',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 15.0,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatePicker3 extends StatefulWidget {
  final String hint;
  final DateTime initialDate;
  final DateTime startDate;
  final DateTime endDat;
  final Function(String) data;
  bool shared = false;

  DatePicker3(
      {Key key,
      this.hint,
      this.data,
      this.initialDate,
      this.startDate,
      this.endDat})
      : super(key: key);
  DatePicker3.shared(
      {Key key,
      this.hint,
      this.data,
      this.shared = true,
      this.initialDate,
      this.startDate,
      this.endDat})
      : super(key: key);

  @override
  _DatePicker3State createState() => _DatePicker3State();
}

class _DatePicker3State extends State<DatePicker3> {
  DateTime _date;
  bool _isEmpty;
  String text;

  // String today = DateFormat("yyyy-M-dd").format(DateTime.now());

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.startDate,
      lastDate: widget.endDat,
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
        widget.data(newdateFormat(_date));
        _isEmpty = false;
        text = null;
        //print(_date.toString());
      });
    }
  }

  String newdateFormat(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
    // return DateFormat.yMMMd().format(_date);
  }

  @override
  void initState() {
    _isEmpty = widget.initialDate == null;
    _date = widget.initialDate != null ? widget.initialDate : DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    text = widget.hint ?? "Select Date";
    // final _height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // FocusNode myFocusNode = new FocusNode();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: InkWell(
        onTap: () => selectDate(context),
        child: PhysicalModel(
          elevation: 1.5,
          borderRadius: BorderRadius.circular(5.0),
          color: themeProvider.isLightTheme
              ? Colors.white
              : Colors.white.withOpacity(0.1),
          child: Container(
            width: widget.shared ? width * 0.45 : double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            // height: 48.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _isEmpty
                        ? text
                        : DateFormat("yyyy-M-dd").format(DateTime.now()) ==
                                newdateFormat(_date)
                            ? 'Today'
                            : newdateFormat(_date),
                    style: GoogleFonts.comfortaa(
                        color: themeProvider.isLightTheme
                            ? Colors.grey[700]
                            : Colors.grey[300],
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(
                  CupertinoIcons.calendar,
                  size: 20.0,
                  color: themeProvider.isLightTheme
                      ? Colors.grey[700]
                      : Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String label;
  final double width;
  final double fontSize;
  final Function onPressed;
  final bool isActive;
  final bool isLoading;
  final Color color;
  bool outlined = false;

  CustomButton({
    Key key,
    @required this.label,
    this.width,
    @required this.onPressed,
    @required this.isActive,
    this.isLoading,
    this.fontSize,
    this.color,
  }) : super(key: key);

  CustomButton.outlined({
    Key key,
    this.label,
    this.width,
    this.outlined = true,
    this.onPressed,
    this.isActive,
    this.isLoading,
    this.fontSize,
    this.color,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final def = Provider.of<Globals>(context);

    final width = MediaQuery.of(context).size.width;
    final buttonWidth = widget.width ?? width;
    // bool loading = widget.isLoading ?? false;

    return GestureDetector(
      onTap: () => widget.isActive
          ? widget.onPressed()
          : () {
              HapticFeedback.heavyImpact();
            },
      child: widget.outlined
          ? Container(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              width: buttonWidth,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 2.0,
                  color:
                      widget.isActive ? Constants.mainColor : Colors.grey[400],
                ),
              ),
              child: Center(
                child: def.getLoading
                    ? SpinKitCircle(color: Colors.white, size: 26.0)
                    : Text(
                        widget.label.toUpperCase() ?? "Submit".toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: widget.fontSize ?? 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            )
          : PhysicalModel(
              color: widget.isActive
                  ? widget.color ?? Constants.mainColor
                  : Colors.grey[400],
              elevation: 2.0,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                width: buttonWidth,
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? widget.color ?? Constants.mainColor
                      : Colors.grey[400],
                  borderRadius: BorderRadius.circular(buttonWidth / 2),
                  border: Border.fromBorderSide(BorderSide.none),
                ),
                child: Center(
                  child: def.getLoading
                      ? SpinKitCircle(color: Colors.white, size: 26.0)
                      : Text(
                          widget.label.toUpperCase() ?? "Submit".toUpperCase(),
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: widget.fontSize ?? 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
    );
  }
}

class CustomButtonSize extends StatelessWidget {
  final IconData icon;
  final VoidCallback function;
  const CustomButtonSize(
      {Key key, @required this.icon, @required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: PhysicalModel(
        elevation: 10,
        color: Colors.red,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
              color: Constants.mainColor,
              borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            onPressed: null,
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class PinputField extends StatefulWidget {
  final TextEditingController controller;
  final int length;
  final String label;
  final bool obscure;

  const PinputField(
      {Key key, this.controller, this.label, this.obscure, this.length})
      : super(key: key);
  @override
  _PinputFieldState createState() => _PinputFieldState();
}

class _PinputFieldState extends State<PinputField> {
  bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscure ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final int pinLength = widget.length ?? Constants.kPinLength;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.lock,
                size: 30,
                color: Constants.mainColor,
              )),
          SizedBox(width: 20),
          Expanded(
            child: PinPut(
              // eachFieldPadding: EdgeInsets.all(5.0),
              fieldsCount: pinLength,
              controller: widget.controller,
              autofocus: false,
              onTap: () {},
              obscureText: '●',
              eachFieldHeight: height * 0.06,
              eachFieldWidth: width * 0.13,
              textStyle: GoogleFonts.comfortaa(
                color: themeProvider.isLightTheme
                    ? Colors.grey[7000]
                    : Colors.grey[300],
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              preFilledWidget: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: themeProvider.themeMode().textColor),
                  shape: BoxShape.circle,
                  color: themeProvider.isLightTheme
                      ? Colors.grey.shade50
                      : Colors.white.withOpacity(0.1),
                ),
              ),
              followingFieldDecoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                shape: BoxShape.circle,
                color: themeProvider.isLightTheme
                    ? Colors.grey.shade50
                    : Colors.white.withOpacity(0.1),
              ),
              submittedFieldDecoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.green[500]),
                shape: BoxShape.circle,
                color: themeProvider.isLightTheme
                    ? Colors.grey.shade50
                    : Colors.white.withOpacity(0.1),
              ),
              selectedFieldDecoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.blue[500]),
                shape: BoxShape.circle,
                color: themeProvider.isLightTheme
                    ? Colors.grey.shade50
                    : Colors.white.withOpacity(0.1),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTextInput extends StatefulWidget {
  final bool amount;
  final TextEditingController controller;
  final Function(String) onEdited;
  final TextInputType keyboard;
  final String label;
  final String value;
  final Widget suffix;
  final bool readOnly;
  final int maxLength;
  final int maxLines;
  bool shared = false;
  CustomTextInput({
    Key key,
    this.controller,
    this.label,
    this.suffix,
    this.onEdited,
    this.keyboard,
    this.readOnly,
    this.value,
    this.maxLength,
    this.maxLines,
    this.amount = false,
  }) : super(key: key);
  CustomTextInput.sharedSpace({
    Key key,
    this.controller,
    this.shared = true,
    this.label,
    this.suffix,
    this.onEdited,
    this.keyboard,
    this.readOnly,
    this.value,
    this.maxLength,
    this.maxLines,
    this.amount = false,
  }) : super(key: key);
  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final _height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return PhysicalModel(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(5.0),
      color: themeProvider.isLightTheme
          ? Colors.white
          : Colors.white.withOpacity(0.1),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        width: widget.shared ? width * 0.45 : width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextField(
          maxLength: widget.maxLength ?? null,
          maxLines: widget.maxLines ?? null,
          keyboardType: widget.keyboard ?? TextInputType.text,
          controller: widget.controller,
          textAlign: TextAlign.start,
          readOnly: widget.readOnly ?? false,

          style: GoogleFonts.comfortaa(
            color: themeProvider.isLightTheme
                ? Colors.grey[700]
                : Colors.grey[300],
            fontSize: 15.0,
          ),
          onChanged: (val) {
            widget.onEdited(val);
          },
          // onEditingComplete: widget.onEdited(),
          decoration: InputDecoration(
            hintText: widget.label ?? 'Enter text',
            hintStyle: GoogleFonts.comfortaa(
              color: Colors.grey[500],
              fontSize: 13.0,
            ),
            suffixIcon: widget.suffix ??
                Icon(
                  Icons.edit_outlined,
                  size: 20.0,
                  color: Colors.grey[500],
                ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
