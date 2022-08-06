// import 'dart:typed_data';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
// import 'dart:io';
// import 'package:flutter/services.dart' show rootBundle;

// import '../../../models/transHistoryModel.dart';

// Future<Uint8List> makePdf(TransHistoryDatum invoice) async {
//   final pdf = Document();
//   final file = File("example.pdf");
//   final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
//   pdf.addPage(
//     Page(
//       build: (context) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Text("Attention to: ${invoice.channel}"),
//                     Text(invoice.channel),
//                   ],
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                 ),
//                 SizedBox(
//                   height: 150,
//                   width: 150,
//                   child: Image(imageLogo),
//                 )
//               ],
//             ),
//             Container(height: 50),
//             Table(
//               border: TableBorder.all(color: PdfColors.black),
//               children: [
//                 TableRow(
//                   children: [
//                     Padding(
//                       child: Text(
//                         'INVOICE FOR PAYMENT',
//                         style: Theme.of(context).header4,
//                         textAlign: TextAlign.center,
//                       ),
//                       padding: EdgeInsets.all(20),
//                     ),
//                   ],
//                 ),
//                 ...invoice.items.map(
//                   (e) => TableRow(
//                     children: [
//                       Expanded(
//                         child: PaddedText(e.description),
//                         flex: 2,
//                       ),
//                       Expanded(
//                         child: PaddedText("\$${e.cost}"),
//                         flex: 1,
//                       )
//                     ],
//                   ),
//                 ),
//                 TableRow(
//                   children: [
//                     PaddedText('TAX', align: TextAlign.right),
//                     PaddedText('invoice.amount '),
//                   ],
//                 ),
//                 TableRow(
//                   children: [PaddedText('TOTAL', align: TextAlign.right), PaddedText('\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')],
//                 )
//               ],
//             ),
//             Padding(
//               child: Text(
//                 "THANK YOU FOR YOUR CUSTOM!",
//                 style: Theme.of(context).header2,
//               ),
//               padding: EdgeInsets.all(20),
//             ),
//             Text("Please forward the below slip to your accounts payable department."),
//             Divider(
//               height: 1,
//               borderStyle: BorderStyle.dashed,
//             ),
//             Container(height: 50),
//             Table(
//               border: TableBorder.all(color: PdfColors.black),
//               children: [
//                 TableRow(
//                   children: [
//                     PaddedText('Account Number'),
//                     PaddedText(
//                       '1234 1234',
//                     )
//                   ],
//                 ),
//                 TableRow(
//                   children: [
//                     PaddedText(
//                       'Account Name',
//                     ),
//                     PaddedText(
//                       'ADAM FAMILY TRUST',
//                     )
//                   ],
//                 ),
//                 TableRow(
//                   children: [
//                     PaddedText(
//                       'Total Amount to be Paid',
//                     ),
//                     PaddedText('\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
//                   ],
//                 )
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(30),
//               child: Text(
//                 'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
//                 style: Theme.of(context).header3.copyWith(
//                       fontStyle: FontStyle.italic,
//                     ),
//                 textAlign: TextAlign.center,
//               ),
//             )
//           ],
//         );
//       },
//     ),
//   );
//  return await file.writeAsBytes(await pdf.save());

// }

// Widget PaddedText(
//   final String text, {
//   final TextAlign align = TextAlign.left,
// }) =>
//     Padding(
//       padding: EdgeInsets.all(10),
//       child: Text(
//         text,
//         textAlign: align,
//       ),
//     );

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

final pdf = pw.Document();

writeOnPdf() {
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
      ];
    },
  ));
}

Future savePdf() async {
  Directory documentDirectory = await getApplicationDocumentsDirectory();

  String documentPath = documentDirectory.path;

  File file = File("$documentPath/example.pdf");

  file.writeAsBytesSync(pdf.save());
}
