// @dart=2.9
// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomProgress extends StatefulWidget {
  final double width;
  bool disableButton;
  List<String> data;
  List<StepperModel> stepperData;
  int index;
  Function(String) onTap;
  String selected;

  CustomProgress(
      {Key key,
      this.width,
      this.disableButton = false,
      this.onTap,
      this.stepperData,
      this.selected})
      : super(key: key);
  CustomProgress.disabled({
    Key key,
    @required this.width,
    @required this.data,
    @required this.index,
    this.disableButton = true,
  }) : super(key: key);

  @override
  _CustomProgressState createState() => _CustomProgressState();
}

class _CustomProgressState extends State<CustomProgress> {
  String selected;
  @override
  void initState() {
    super.initState();
    //print(widget.selected);
    setState(() {
      selected = widget.selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<StepperModel> data = widget.stepperData;

    return Container(
      margin: EdgeInsets.symmetric(vertical: widget.disableButton ? 10.0 : 20),
      height: 35,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xffD1D1D1),
        ),
      ),
      child: Center(
        child: Stack(
          children: [
            if (widget.disableButton) ...[
              for (var i = 0; i < widget.data.length; i++) ...[
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: widget.width * i / widget.data.length,
                  child: ProgressContainer(
                    funtion: null,
                    color: widget.data.length - i - 1 == widget.index
                        ? Colors.red
                        : Colors.white,
                    textColor: widget.data.length - i - 1 == widget.index
                        ? Colors.white
                        : Colors.black,
                    title: widget.data[i],
                    width: i == widget.data.length - 1
                        ? widget.width * 1 / widget.data.length - 1
                        : widget.width * 1 / widget.data.length + 24,
                  ),
                ),
              ]
            ] else ...[
              for (var i = 0; i < data.length; i++) ...[
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: widget.width * i / data.length,
                  child: ProgressContainer(
                    funtion: (val) {
                      setState(() {
                        selected = val;
                        widget.onTap(val);
                      });
                    },
                    color:
                        selected == data[i].name ? data[i].color : Colors.white,
                    title: data[i].name,
                    textColor: !(selected == data[i].name)
                        ? Colors.black
                        : Colors.white,
                    width: i == data.length - 1
                        ? widget.width * 1 / data.length - 1
                        : widget.width * 1 / data.length + 24,
                  ),
                ),
              ]
            ]
            // Positioned(
            //   top: 0,
            //   bottom: 0,
            //   right: widget.width * i / data.length,
            //   child: ProgressContainer(
            //     funtion: (val) {
            //       setState(() {
            //         selected = val;
            //       });
            //     },
            //     color:
            //         selected == data[i].name ? data[i].color : Colors.white,
            //     title: data[i].name,
            //     width: i == data.length - 1
            //         ? widget.width * 1 / data.length - 1
            //         : widget.width * 1 / data.length + 24,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ProgressContainer extends StatelessWidget {
  final double width;
  final String title;
  final Function(String) funtion;
  final Color color;
  final Color textColor;

  const ProgressContainer(
      {Key key,
      this.width,
      this.title,
      this.color,
      this.funtion,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => funtion(title),
      child: Container(
        height: 35,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xffD1D1D1),
          ),
          color: color ?? Colors.green,
        ),
        child: Center(
            child: Text(
          title ?? "Step",
          style: GoogleFonts.comfortaa(
              fontSize: 12.0, color: textColor ?? Colors.black),
        )),
      ),
    );
  }
}

class StepperModel {
  final String name;
  final Color color;

  StepperModel({this.name, this.color});
}
