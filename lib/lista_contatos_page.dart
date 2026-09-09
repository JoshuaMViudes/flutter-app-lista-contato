import 'package:app_listacontatos/database_helper.dart';
import 'package:flutter/material.dart';

class ListaContatosPage extends StatefulWidget {
  const ListaContatosPage({super.key});

  @override
  State<ListaContatosPage> createState() => _ListaContatosPageState();
}

class _ListaContatosPageState extends State<ListaContatosPage> {
  List<Map<String, dynamic>> contatos = [];

  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  void carregarContatos() async {
    final dados = await DatabaseHelper.buscarContatos();
    setState(() {
      contatos = dados;
    });
  }

  void adicionarContato() {
    final inicialContatoController = TextEditingController();
    final nomeContatoController = TextEditingController();
    final numeroContatoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Novo Contato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: inicialContatoController,
                decoration: InputDecoration(hintText: 'Digite a sigla...'),
              ),
              TextField(
                controller: nomeContatoController,
                decoration: InputDecoration(hintText: 'Digite o nome...'),
              ),
              TextField(
                controller: numeroContatoController,
                decoration: InputDecoration(hintText: 'Digite o número...'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                //Função para fechar qualquer janela/tela
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (nomeContatoController.text.isNotEmpty &&
                    numeroContatoController.text.isNotEmpty &&
                    inicialContatoController.text.isNotEmpty) {
                  await DatabaseHelper.inserirContato(
                    inicialContatoController.text,
                    nomeContatoController.text,
                    numeroContatoController.text,
                  );
                  carregarContatos();

                  if (!context.mounted) return;

                  Navigator.pop(context);
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Contatos"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 15, 117, 168),
      ),
      body: contatos.isEmpty
          ? Center(
              child: Text('Nenhum contato ainda. Toque em + para adicionar'),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: contatos.length,
              itemBuilder: (context, index) {
                final contato = contatos[index];
                final bool situacao = contato['situacao'] == 1;

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green,
                      child: Text(contato['inicial']),
                    ),
                    title: Text(
                      contato['nome'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(contato['numero']),
                    trailing: Icon(
                      situacao ? Icons.star : Icons.star,
                      color: situacao ? Colors.orange : Colors.grey,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => adicionarContato(),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
