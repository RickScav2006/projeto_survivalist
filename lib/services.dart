import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class PDFViewerPage extends StatefulWidget {
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String _localPath = '';

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  // Carrega o arquivo PDF dos ativos para o dispositivo
  Future<void> _loadPdf() async {
    // Carregar PDF da pasta de assets
    final ByteData data = await rootBundle.load('assets/pdfs/UROP_US.pdf');
    final bytes = data.buffer.asUint8List();

    // Obter diretório temporário para armazenar o arquivo
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/UROP_US.pdf';

    // Salvar o arquivo PDF no diretório temporário
    final file = File(filePath);
    await file.writeAsBytes(bytes);

    setState(() {
      _localPath = filePath; // Atualizar o caminho do PDF
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_localPath.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Carregando PDF...'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Visualizador de PDF'),
        ),
        body: PDFView(
          filePath: _localPath, // Exibir PDF do caminho local
        ),
      );
    }
  }

  getTemporaryDirectory() {}
}
