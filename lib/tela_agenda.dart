import 'package:flutter/material.dart';
import 'tela_adicionar.dart';

class TelaAgenda extends StatefulWidget {
  @override
  _TelaAgendaState createState() => _TelaAgendaState();
}

class _TelaAgendaState extends State<TelaAgenda> {
  List<String> tarefas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Agenda"),
      ),
      ), // 
      
      body: tarefas.isEmpty
          ? Center(
              child: Text(
                "Nenhuma tarefa ainda",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(tarefas[index]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final novaTarefa = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaAdicionar(),
            ),
          );

          if (novaTarefa != null && novaTarefa != "") {
            setState(() {
              tarefas.add(novaTarefa);
            });
          }
        },
      ),
    );
  }
}