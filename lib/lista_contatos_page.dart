import 'package:flutter/material.dart';

class ListaContatosPage extends StatelessWidget {
  const ListaContatosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> contatos = [
      {
        "inicial": "AS",
        "nome": "Ana Souza",
        "numero": "(11) 98765-4321",
        "situacao": true,
      },
      {
        "inicial": "BL",
        "nome": "Bruno Lima",
        "numero": "(14) 99123-4567",
        "situacao": false,
      },
      {
        "inicial": "CM",
        "nome": "Carla Mendes",
        "numero": "(21) 97654-3210",
        "situacao": true,
      },
      {
        "inicial": "DA",
        "nome": "Diego Alves",
        "numero": "(19) 98888-1234",
        "situacao": false,
      },
      {
        "inicial": "ET",
        "nome": "Elisa Torres",
        "numero": "(17) 99999-5678",
        "situacao": false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Contatos"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 15, 117, 168),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          final bool situacao = contato['situacao'];

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
        onPressed: () {},
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
