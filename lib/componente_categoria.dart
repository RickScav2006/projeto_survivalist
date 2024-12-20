import 'package:flutter/material.dart';
import 'package:share/share.dart'; // Importando o pacote de compartilhamento
import 'package:shared_preferences/shared_preferences.dart'; // Importando SharedPreferences
import 'entidade_categoria.dart';

class ComponenteCategoria extends StatefulWidget {
  final SurvivalCategory category;

  ComponenteCategoria({required this.category});

  @override
  _ComponenteCategoriaState createState() => _ComponenteCategoriaState();
}

class _ComponenteCategoriaState extends State<ComponenteCategoria> {
  TextEditingController _noteController = TextEditingController();
  String? _savedNote;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  // Função para carregar a anotação salva
  void _loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedNote = prefs.getString('note_${widget.category.title}');
      _noteController.text = _savedNote ?? ''; // Carrega a anotação, se houver
    });
  }

  // Função para salvar a anotação
  void _saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('note_${widget.category.title}', _noteController.text);
    setState(() {
      _savedNote = _noteController.text; // Atualiza a anotação salva
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Anotação salva!')));
  }

  // Função de compartilhamento
  void _shareCategory(BuildContext context) {
    final String content = '''
    Título: ${widget.category.title}
    Descrição: ${widget.category.description}

    Segunda descrição: ${widget.category.secondaryDescription}

    Confira mais sobre esta categoria!    
    ''';

    Share.share(content);  // Compartilha o conteúdo como texto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareCategory(context), // Chama a função de compartilhamento
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.category.description,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Image.network(
                widget.category.imagePath,
                fit: BoxFit.cover,
                height: 200.0,
              ),
              SizedBox(height: 16.0),
              Text(
                widget.category.secondaryTitle,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                widget.category.secondaryDescription,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              // Campo para adicionar uma nota pessoal
              TextField(
                controller: _noteController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Adicionar uma nota pessoal',
                  hintText: 'Escreva sua anotação aqui...',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveNote,
                child: Text('Salvar Nota'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              if (_savedNote != null && _savedNote!.isNotEmpty) ...[
                SizedBox(height: 16.0),
                Text(
                  'Nota Salva: $_savedNote',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
