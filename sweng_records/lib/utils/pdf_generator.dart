import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

class PdfGenerator {
  static Future<void> generateChallanPDF(List challans) async {
    final pdf = pw.Document();

    final Uint8List logoBytes =
        (await rootBundle.load('assets/Muet-logo.png')).buffer.asUint8List();
    final logoImage = pw.MemoryImage(logoBytes);

    for (var challan in challans) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Stack(
              children: [
                /// Watermark Logo
                pw.Positioned.fill(
                  child: pw.Opacity(
                    opacity: 0.08,
                    child: pw.Center(
                      child: pw.Image(logoImage, width: 300, height: 300),
                    ),
                  ),
                ),

                /// Main Challan Content
                pw.Padding(
                  padding: const pw.EdgeInsets.all(24),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Center(
                        child: pw.Text(
                          "MEHRAN UNIVERSITY OF ENGINEERING & TECHNOLOGY\nJAMSHORO",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Bank Challan (HBL)",
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(width: 10),
                          pw.Image(logoImage, width: 100, height: 150),
                          pw.SizedBox(width: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerRight,
                            child: pw.BarcodeWidget(
                              barcode: pw.Barcode.qrCode(),
                              data:
                                  'Challan No: ${challan['challan_no']}, Roll No: ${challan['roll_no']}',
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ],
                      ),

                      pw.SizedBox(height: 14),

                      /// Table of values
                      pw.Table(
                        border: pw.TableBorder.all(width: 0.5),
                        columnWidths: {
                          0: pw.FlexColumnWidth(3),
                          1: pw.FlexColumnWidth(7),
                        },
                        children: [
                          _buildTableRow("MUET Ref", challan['challan_no']),
                          _buildTableRow("Roll No", challan['roll_no']),
                          _buildTableRow("Name", challan['challan_name']),
                          _buildTableRow(
                            "Father Name",
                            challan['father_name'] ?? "-",
                          ),
                          _buildTableRow(
                            "Program",
                            challan['program'] ?? "BE Program",
                          ),
                          _buildTableRow(
                            "Fee Description",
                            challan['fee_description'] ?? "Admission",
                          ),
                          _buildTableRow(
                            "Semester",
                            challan['semester_year'] ?? "-",
                          ),
                          _buildTableRow(
                            "Amount (Rs)",
                            challan['fees_amount'].toString(),
                          ),
                          _buildTableRow("Status", challan['status']),
                          _buildTableRow("Date", challan['submission_date']),
                          if (challan['remarks'] != null &&
                              challan['remarks'].isNotEmpty)
                            _buildTableRow("Remarks", challan['remarks']),
                        ],
                      ),

                      pw.SizedBox(height: 16),

                      /// Depositor Info
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Depositor Name: ${challan['depositor_name'] ?? "__________"}",
                          ),
                          pw.Text(
                            "CNIC: ${challan['depositor_cnic'] ?? "__________"}",
                          ),
                        ],
                      ),

                      // pw.SizedBox(height: 24),
                      pw.SizedBox(height: 20),

                      /// Signatures
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("Manager Signature: _______________"),
                          pw.Text("Cashier Signature: _______________"),
                        ],
                      ),

                      pw.SizedBox(height: 10),
                      pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          "Department Copy",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  static pw.TableRow _buildTableRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text(
            label,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(value)),
      ],
    );
  }
}
