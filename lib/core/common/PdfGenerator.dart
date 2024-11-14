import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../models/generate_pdf_model.dart';

pw.Widget dottedLine() {
  return pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.center,
    children: List.generate(
      100, // Number of dots
          (index) => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 2),
        child: pw.Container(
          width: 10,
          height: 3,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            color: PdfColors.grey400,
          ),
        ),
      ),
    ),
  );
}
Future<void> generatePdfFunction({required GeneratePdfModel pdfmodel}) async {
  Future<Uint8List> loadAssetImage(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }
  final pdf = pw.Document();
  // Load the background image from assets
  final Uint8List bgImageData = await loadAssetImage('assets/images/pdfBg.png');
  final Uint8List logoImageData = await loadAssetImage('assets/images/logo.png');
  final Uint8List signImageData = await loadAssetImage('assets/images/sign.png');
  final bgImage = pw.MemoryImage(bgImageData);
  final logoImage = pw.MemoryImage(logoImageData);
  final signImage = pw.MemoryImage(signImageData);

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child:

          pw.Stack(
            children: [
              pw.Positioned.fill(
                child: pw.Image(bgImage, fit: pw.BoxFit.contain),
              ),

           pw.Column(
             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
             children: [
               pw.Column(
                 crossAxisAlignment: pw.CrossAxisAlignment.start,
                 children: [
                   // Header with Logo
                   pw.Row(
                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                     children: [
                       pw.Image(
                           logoImage ,height: 80
                         // style: pw.TextStyle(
                         //   fontSize: 20,
                         //   fontWeight: pw.FontWeight.bold,
                         // ),
                       ),
                       // pw.Container(
                       //   height: 60,
                       //   width: 60,
                       //   // child: pw.Image(
                       //   //   pw.(
                       //   //     File(logo).readAsBytesSync(),
                       //   //   ),
                       //   // ),
                       // ),

                       pw.Column(
                         crossAxisAlignment: pw.CrossAxisAlignment.end,
                         children: [
                           pw.Text(
                             "KUMARAKOM",
                             style: pw.TextStyle(
                               fontSize: 16,
                               fontWeight: pw.FontWeight.bold,
                             ),
                           ),
                           pw.SizedBox(height: 10),
                           pw.Text(
                             "Cheepunkal P.O. Kumarakom, kottayam, Kerala - 686563",
                             style: pw.TextStyle(
                               fontSize: 12,
                               color: PdfColors.grey,
                             ),
                             textAlign: pw.TextAlign.center,
                           ),
                           pw.SizedBox(height: 8),
                           pw.Text(
                             "e-mail: unknown@gmail.com",
                             style: pw.TextStyle(
                               fontSize: 12,
                               color: PdfColors.grey,
                             ),
                             textAlign: pw.TextAlign.center,
                           ),
                           pw.SizedBox(height: 8),
                           pw.Text(
                             "Mob: +91 9876543210 | +91 9786543210",
                             style: pw.TextStyle(
                               fontSize: 12,
                               color: PdfColors.grey,
                             ),
                             textAlign: pw.TextAlign.center,
                           ),
                           pw.SizedBox(height: 8),
                           pw.Text(
                             "GST No: 32AABCU9603R1ZW",
                             style: pw.TextStyle(
                               fontSize: 12,
                               fontWeight: pw.FontWeight.bold,
                             ),
                             textAlign: pw.TextAlign.center,
                           ),
                           pw.SizedBox(height: 16),
                         ],
                       )
                     ],
                   ),
                   pw.SizedBox(height: 8),
                   pw.Text(
                     "Patient Details",
                     style: pw.TextStyle(
                       fontSize: 16,
                       fontWeight: pw.FontWeight.bold,

                     ),
                   ),
                   dottedLine()
,
                   pw.SizedBox(height: 8),

                   // Patient Information Section
                   pw.Row(
                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                     children: [
                       pw.Column(
                         crossAxisAlignment: pw.CrossAxisAlignment.start,
                         children: [
                           pw.Text(pdfmodel.name),
                           pw.Text(pdfmodel.address),
                           pw.Text("WhatsApp Number: ${pdfmodel.phone}"),
                         ],
                       ),
                       pw.Column(
                         crossAxisAlignment: pw.CrossAxisAlignment.start,
                         children: [
                           pw.Text("Booked On: ${pdfmodel.dateNdTime}"),
                           pw.Text("Treatment Date: ${pdfmodel.dateNdTime}"),
                           // pw.Text("Treatment Time: 11:00 am"),
                         ],
                       ),
                     ],
                   ),
                   pw.SizedBox(height: 16),

                   // Treatments Table
                   pw.Text("Treatment Details", style: pw.TextStyle(fontSize: 14)),
                   pw.SizedBox(height: 8),
                   pw.TableHelper.fromTextArray(
                     context: context,
                     cellAlignment: pw.Alignment.centerLeft,
                     headers: ['Treatment', 'Price', 'Male', 'Female', 'Total'],
                     data: [
                       ['Panchakarma', '230', '4', '4', '2,540'],
                       ['Njavara Kizhi Treatment', '230', '4', '4', '2,540'],
                       ['Panchakarma', '230', '4', '6', '2,540'],
                     ],
                     headerDecoration: null, // No border or decoration for header
                     rowDecoration: null,
                     border: null, // No border or decoration for rows
                     cellStyle: pw.TextStyle(fontSize: 10), // Customize as needed
                     headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                     headerAlignments: {
                       0: pw.Alignment.centerLeft,
                       1: pw.Alignment.centerLeft,
                       2: pw.Alignment.centerLeft,
                       3: pw.Alignment.centerLeft,
                       4: pw.Alignment.centerRight,
                     },
                   ),

                   pw.SizedBox(height: 16),
                   dottedLine()
,

                   // Summary Amount Section
                   pw.Align(
                       alignment: pw.Alignment.centerRight,
                       child:
                       pw.Container(
                         width: 150,
                         child:  pw.Column(
                           crossAxisAlignment: pw.CrossAxisAlignment.start,
                           children: [
                             pw.Row(
                               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                               children: [
                                 pw.Text("Total Amount",style: pw.TextStyle(fontWeight:  pw.FontWeight.bold)),
                                 pw.Text("7,620",style: pw.TextStyle(fontWeight:  pw.FontWeight.bold)),
                               ],
                             ),
                             pw.Row(
                               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                               children: [
                                 pw.Text("Discount"),
                                 pw.Text("500"),
                               ],
                             ),
                             pw.Row(
                               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                               children: [
                                 pw.Text("Advance"),
                                 pw.Text("1,200"),
                               ],
                             ),
                             pw.Row(
                               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                               children: [
                                 pw.Text("Balance",style: pw.TextStyle(fontWeight:  pw.FontWeight.bold)),
                                 pw.Text("5,920",style: pw.TextStyle(fontWeight:  pw.FontWeight.bold)),
                               ],
                             ),


                           ],
                         ),
                       )
                   ),
                   pw.SizedBox(height: 16),

pw.Align(
  alignment: pw.Alignment.centerRight,
  child:
  pw.Container(
      width: 250,
      child:

      pw.Center(
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            // Thank You Text
            pw.Text(
              'Thank you for choosing us',
              style: pw.TextStyle(
                fontSize: 14,
                color: PdfColors.green800,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),

            // Subtitle Text
            pw.Text(
              'Your well-being is our commitment, and we are honored you have entrusted us with your health journey',
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColors.grey700,
              ),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 30),

            // Signature Placeholder
            pw.Container(
                height: 50,
                width: 100,
                child:  pw.Image(signImage, fit: pw.BoxFit.contain)
            ),
          ],
        ),
      )

  )
)
                   // Footer Message

                 ],
               ),
             pw.Column(
               children: [
                 dottedLine()
                 ,
                 pw.Center(
                   child: pw.Text(
                     "Thank you for choosing us Your well-being is our commitment, and we're honored you've entrusted us with your health journey",
                     textAlign: pw.TextAlign.center,
                     style: pw.TextStyle(
                       color: PdfColors.grey400,
                       // color: PdfColor(1, 1, 1),
                       fontSize: 10,
                     ),
                   ),
                 ),
               ]
             )
             ]
           ),


            ]
          )
        );
      },
    ),
  );
  // Function to create a horizontal dotted line


  // Save and open PDF
  // Save PDF to a temporary location
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/invoice.pdf");
  await file.writeAsBytes(await pdf.save());

  // Preview PDF directly in the app
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
