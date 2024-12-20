import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;  // Recebe o URL ou caminho do arquivo PDF

  PdfViewerPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizando PDF'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        // Carregando o PDF (se for URL ou caminho local)
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar o PDF.'));
          } else {
            return PDFView(
              filePath: pdfUrl,  // Caminho do arquivo PDF (URL ou local)
            );
          }
        }, future: null,
      ),
    );
  }
}
