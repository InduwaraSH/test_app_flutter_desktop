import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfStyledPage extends StatefulWidget {
  final String S_Num;
  final String PlaceOfCoupe;
  final String LetterNo;
  final String Dateinforemed;
  const PdfStyledPage(
    this.S_Num,
    this.PlaceOfCoupe,
    this.LetterNo,
    this.Dateinforemed, {
    super.key,
  });

  @override
  State<PdfStyledPage> createState() => _PdfStyledPageState();
}

class _PdfStyledPageState extends State<PdfStyledPage> {
  late String S_Num;
  late String PlaceOfCoupe;
  late String LetterNo;
  late String Dateinforemed;

  @override
  void initState() {
    super.initState();
    S_Num = widget.S_Num;
    PlaceOfCoupe = widget.PlaceOfCoupe;
    LetterNo = widget.LetterNo;
    Dateinforemed = widget.Dateinforemed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: PdfPreview(
        build: (format) => _generateStyledPdf(format),
        pdfFileName: "donated_timber_register $S_Num .pdf",
        allowSharing: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        pageFormats: const {"A4": PdfPageFormat.a4},
      ),
    );
  }

  Future<Uint8List> _generateStyledPdf(PdfPageFormat format) async {
    final doc = pw.Document();

    final regular = pw.Font.ttf(await rootBundle.load("fonts/RoboSerif.ttf"));
    final bold = pw.Font.ttf(await rootBundle.load("fonts/DMSerif.ttf"));
    doc.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            /// Title
            pw.Text(
              "Enumeration And Wayside\nDeport Register For Donated Timber.",
              style: pw.TextStyle(
                font: bold,
                fontSize: 20,
                color: PdfColors.indigo,
              ),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 30),

            /// From - To Section
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          text: "From : ",
                          style: pw.TextStyle(font: bold, fontSize: 12),
                          children: [
                            pw.TextSpan(
                              text: "RM Branch in Matara",
                              style: pw.TextStyle(font: regular, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      pw.RichText(
                        text: pw.TextSpan(
                          text: "To      : ",
                          style: pw.TextStyle(font: bold, fontSize: 12),
                          children: [
                            pw.TextSpan(
                              text: "ARM Branch in Galle",
                              style: pw.TextStyle(font: regular, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 30),

            /// Table-like container
            pw.Container(
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(8),
                border: pw.Border.all(color: PdfColors.indigo, width: 1),
              ),
              padding: const pw.EdgeInsets.all(10),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _buildRow("Serial No", S_Num, bold, regular),
                  _divider(),
                  _buildRow("Place of Coupe", PlaceOfCoupe, bold, regular),
                  _divider(),
                  _buildRow("Letter No", LetterNo, bold, regular),
                  _divider(),
                  _buildRow("Date informed", Dateinforemed, bold, regular),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return doc.save();
  }

  pw.Widget _buildRow(
    String label,
    String value,
    pw.Font bold,
    pw.Font regular,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            flex: 2,
            child: pw.Text(
              label,
              style: pw.TextStyle(font: bold, fontSize: 12),
            ),
          ),
          pw.Text(" :  ", style: pw.TextStyle(font: regular, fontSize: 12)),
          pw.Expanded(
            flex: 3,
            child: pw.Text(
              value,
              style: pw.TextStyle(font: regular, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _divider() {
    return pw.Divider(color: PdfColors.grey400, thickness: 0.5);
  }
}
