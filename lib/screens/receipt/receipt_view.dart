// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

// class ReceiptView extends StatefulWidget {
//   final TransHistoryDatum data;
//   final AccountModelDatum account;
//   const ReceiptView({Key? key, required this.data, required this.account})
//       : super(key: key);

//   @override
//   State<ReceiptView> createState() => _ReceiptViewState();
// }

// class _ReceiptViewState extends State<ReceiptView> {
final pdf = pw.Document();

Future<Widget> generatePDF() async {
  print('ReceiptView ');
  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a5,
    margin: pw.EdgeInsets.all(32),
    build: (pw.Context context) {
      return <pw.Widget>[
        pw.Header(level: 0, child: pw.Text("Easy Approach Document")),
        pw.Paragraph(
            text:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        pw.Paragraph(
            text:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        pw.Header(level: 1, child: pw.Text("Second Heading")),
        pw.Paragraph(
            text:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        pw.Paragraph(
            text:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        pw.Paragraph(
            text:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Malesuada fames ac turpis egestas sed tempus urna. Quisque sagittis purus sit amet. A arcu cursus vitae congue mauris rhoncus aenean vel elit. Ipsum dolor sit amet consectetur adipiscing elit pellentesque. Viverra justo nec ultrices dui sapien eget mi proin sed."),
        pw.Table.fromTextArray(context: context, data: const <List<String>>[
          <String>['Year', 'Ipsum', 'Lorem'],
          <String>['2000', 'Ipsum 1.0', 'Lorem 1'],
          <String>['2001', 'Ipsum 1.1', 'Lorem 2'],
          <String>['2002', 'Ipsum 1.2', 'Lorem 3'],
          <String>['2003', 'Ipsum 1.3', 'Lorem 4'],
          <String>['2004', 'Ipsum 1.4', 'Lorem 5'],
          <String>['2004', 'Ipsum 1.5', 'Lorem 6'],
          <String>['2006', 'Ipsum 1.6', 'Lorem 7'],
          <String>['2007', 'Ipsum 1.7', 'Lorem 8'],
          <String>['2008', 'Ipsum 1.7', 'Lorem 9'],
        ]),
      ];
    },
  ));

  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(pdf.save());
  return PDFViewerScaffold(path: path);
  // material.Navigator.of(context).push(
  //   material.MaterialPageRoute(
  //     builder: (_) => PDFViewerScaffold(path: path),
  //   ),
  // );
}

Future savePdf() async {
  Directory documentDirectory = await getApplicationDocumentsDirectory();

  String documentPath = documentDirectory.path;

  File file = File("$documentPath/example.pdf");

  file.writeAsBytesSync(pdf.save());
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(child: Text('Elijah')),
//     );
//   }
// }
