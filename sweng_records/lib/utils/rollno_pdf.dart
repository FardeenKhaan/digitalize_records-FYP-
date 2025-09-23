import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RollNumberPdfGenerator {
  static Future<void> generate(List students) async {
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.MultiPage(
        build:
            (context) => [
              pw.Text(
                'Student Roll Number List - 2025',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),

              // Table Headers and Data
              pw.Table.fromTextArray(
                headers: [
                  'S.No',
                  'Roll No',
                  'Name',
                  'Father\'s Name',
                  'Section',
                ],
                data: List<List<String>>.generate(
                  students.length,
                  (index) => [
                    '${index + 1}',
                    students[index].rollNumber,
                    students[index].name,
                    students[index].fatherName,
                    students[index].section,
                  ],
                ),
                headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromInt(0xffffffff),
                ),
                headerDecoration: pw.BoxDecoration(
                  color: PdfColor.fromInt(0xff11449D),
                ),
                cellAlignment: pw.Alignment.centerLeft,
                cellPadding: const pw.EdgeInsets.all(8),
              ),
            ],
      ),
    );

    // Display print or save dialog
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
