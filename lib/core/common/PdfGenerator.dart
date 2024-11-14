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

Future<void> generatePdfFunction({required GeneratePdfModel pdfModel}) async {
  Future<Uint8List> loadAssetImage(String path) async {
    final data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  final pdf = pw.Document();

  // Load images
  final Uint8List bgImageData = await loadAssetImage('assets/images/pdfBg.png');
  final Uint8List logoImageData = await loadAssetImage('assets/images/logo.png');
  final Uint8List signImageData = await loadAssetImage('assets/images/sign.png');
  final bgImage = pw.MemoryImage(bgImageData);
  final logoImage = pw.MemoryImage(logoImageData);
  final signImage = pw.MemoryImage(signImageData);

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Stack(
          children: [
            // Background Image
            pw.Positioned.fill(
              child: pw.Image(bgImage, fit: pw.BoxFit.contain),
            ),
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                // Header Section with Logo and Address
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(logoImage, height: 80),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "KUMARAKOM",
                          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          "Cheepunkal P.O. Kumarakom, kottayam, Kerala - 686563",
                          style: pw.TextStyle(fontSize: 12, color: PdfColors.grey),
                        ),
                        pw.Text("e-mail: unknown@gmail.com", style: pw.TextStyle(fontSize: 12, color: PdfColors.grey)),
                        pw.Text("Mob: +91 9876543210 | +91 9786543210", style: pw.TextStyle(fontSize: 12, color: PdfColors.grey)),
                        pw.Text("GST No: 32AABCU9603R1ZW", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                      ],
                    )
                  ],
                ),
                pw.SizedBox(height: 8),

                // Patient Details Section
                pw.Align(
                  alignment:   pw.Alignment.centerLeft,
                  child:
                  pw.Text("Patient Details", style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),


                ),
                dottedLine(),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Name: ${pdfModel.name}"),
                        pw.Text("Address: ${pdfModel.address}"),
                        pw.Text("WhatsApp Number: ${pdfModel.phone}"),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Booked On: ${pdfModel.dateNdTime}"),
                        pw.Text("Treatment Date: ${pdfModel.dateNdTime}"),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 16),

                // Treatment Details Table
                pw.Align(
                  alignment:   pw.Alignment.centerLeft,
                  child:
                  pw.Text("Treatment Details", style: pw.TextStyle(fontSize: 14)),

                ),
                pw.SizedBox(height: 8),
                pw.TableHelper.fromTextArray(
                  border: null,
                  context: context,
                  headerAlignment: pw.Alignment.centerLeft,

                  headers: ['Treatment', 'Price', 'Male', 'Female', 'Total'],
                  data: [
                    [
                      pdfModel.name,
                      pdfModel.totalAmount.toString(),
                      pdfModel.maleTreatments.toString(),
                      pdfModel.femaleTreatments.toString(),
                      pdfModel.totalAmount.toString(),
                    ]
                  ],
                  cellStyle: pw.TextStyle(fontSize: 10),
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold,color: PdfColors.green),
                ),
                pw.SizedBox(height: 16),
                dottedLine(),

                // Summary Amount Section
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Container(
                    width: 150,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Total Amount", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                            pw.Text(pdfModel.totalAmount.toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Discount"),
                            pw.Text(pdfModel.discountAmount.toString()),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Advance"),
                            pw.Text(pdfModel.advanceAmount.toString()),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("Balance", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                            pw.Text(pdfModel.balanceAmount.toString(), style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),

                // Signature and Thank You Section
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Container(
                    width: 250,
                    child: pw.Center(
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            'Thank you for choosing us',
                            style: pw.TextStyle(fontSize: 14, color: PdfColors.green800, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            'Your well-being is our commitment, and we are honored you have entrusted us with your health journey',
                            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.SizedBox(height: 30),
                          pw.Container(
                            height: 50,
                            width: 100,
                            child: pw.Image(signImage, fit: pw.BoxFit.contain),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                dottedLine(),
                pw.Center(
                  child: pw.Text(
                    "Thank you for choosing us. Your well-being is our commitment, and we're honored you've entrusted us with your health journey.",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(color: PdfColors.grey400, fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  // Save and preview the PDF
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/invoice.pdf");
  await file.writeAsBytes(await pdf.save());
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
