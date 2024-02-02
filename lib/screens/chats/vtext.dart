import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:langchain/langchain.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

// import 'notifiers/index_notifier.dart';

class VText extends StatefulWidget {
  const VText({super.key});

  @override
  State<VText> createState() => _VTextState();
}

class _VTextState extends State<VText> {
  Future<String> cpdf() async {
    try {
      // Load the PDF document.
      final pdfFromAsset = await rootBundle.load('assets/pdf/pdf1.pdf');
      final document =
          PdfDocument(inputBytes: pdfFromAsset.buffer.asUint8List());

      String text = PdfTextExtractor(document).extractText();
      final localPath = await _localPath;
      File file = File('$localPath/output.txt');
      final res = await file.writeAsString(text);

      document.dispose();

      return res.path;
    } catch (e) {
      throw Exception('Error converting pdf to text');
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  String documentVar = '';

  @override
  void initState() {
    loadTextF();
    super.initState();
  }

  loadTextF() async {
    final textFilePathFromPdf = await cpdf();
    final loader = TextLoader(textFilePathFromPdf);
    final documents = await loader.load();
    documentVar = documents.toString();
    log("👉" + documents.toString());
    // CharacterTextSplitter().createDocuments(documentVar);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEXT FROM PDF'),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Text(documentVar.toString().isEmpty
            ? 'First Sync PDF'
            : documentVar.toString()),
      ),
    );
  }
}
