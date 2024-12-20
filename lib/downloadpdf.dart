import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfDownloadPage extends StatelessWidget {
  // Função para solicitar permissões para acesso ao armazenamento
  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      PermissionStatus status = await Permission.storage.request();
      return status.isGranted;
    }
    return true; // No iOS, as permissões são automáticas
  }

  // Função para baixar o PDF
  Future<void> _downloadPdf(String url, String filename) async {
    bool hasPermission = await _requestPermissions();

    if (!hasPermission) {
      print('Permissão de armazenamento negada!');
      return;
    }

    try {
      Dio dio = Dio();
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = '${appDocDir.path}/$filename';

      await dio.download(url, savePath);
      print('PDF salvo em: $savePath');

      // Após o download, você pode informar o usuário ou abrir o arquivo, se necessário.
      // Você pode usar pacotes como `open_file` ou `flutter_full_pdf_viewer` para abrir o arquivo após o download.
    } catch (e) {
      print('Erro ao baixar o arquivo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baixar PDFs'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Escolha um PDF para baixar:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Manual de Sobrevivência em Floresta'),
              trailing: Icon(Icons.download),
              onTap: () {
                _downloadPdf(
                  'https://www.exemplo.com/manual_floresta.pdf',
                  'manual_floresta.pdf',
                );
              },
            ),
            ListTile(
              title: Text('Guia de Primeiros Socorros'),
              trailing: Icon(Icons.download),
              onTap: () {
                _downloadPdf(
                  'https://www.exemplo.com/guia_primeiros_socorros.pdf',
                  'guia_primeiros_socorros.pdf',
                );
              },
            ),
            ListTile(
              title: Text('Dicas de Sobrevivência no Deserto'),
              trailing: Icon(Icons.download),
              onTap: () {
                _downloadPdf(
                  'https://trueprepper.com/wp-content/uploads/Canadian-Military-Basic-Cold-Weather-Training.pdf',
                  'dicas_deserto.pdf',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
