import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

void generatePdf({
  required String name,
  required String executive,
  required String payment,
  required String phone,
  required String address,
  required double totalAmount,
  required double discountAmount,
  required double advanceAmount,
  required double balanceAmount,
  required String dateNdTime,
  required String maleTreatments,
  required String femaleTreatments,
  required String branch,
  required List<int> treatments,
}) async {
  final pdf = pw.Document();

  pdf.addPage(pw.Page(
    build: (pw.Context context) {
      return pw.Column(
        children: [
          pw.Text('Patient Registration', style: pw.TextStyle(fontSize: 24)),
          pw.SizedBox(height: 20),
          pw.Text('Name: $name'),
          pw.Text('Executive: $executive'),
          pw.Text('Payment: $payment'),
          pw.Text('Phone: $phone'),
          pw.Text('Address: $address'),
          pw.Text('Total Amount: $totalAmount'),
          pw.Text('Discount Amount: $discountAmount'),
          pw.Text('Advance Amount: $advanceAmount'),
          pw.Text('Balance Amount: $balanceAmount'),
          pw.Text('Date and Time: $dateNdTime'),
          pw.Text('Branch: $branch'),
          pw.Text('Male Treatments: $maleTreatments'),
          pw.Text('Female Treatments: $femaleTreatments'),
          pw.Text('Treatments: ${treatments.join(', ')}'),
        ],
      );
    },
  ));

  // Save PDF to file or print
  await Printing.layoutPdf(onLayout: (format) => pdf.save());
}
