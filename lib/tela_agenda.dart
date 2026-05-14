import 'package:flutter/material.dart';
import 'tela_adicionar.dart';

class TelaAgenda extends StatefulWidget {
  @override
  _TelaAgendaState createState() => _TelaAgendaState();
}

class _TelaAgendaState extends State<TelaAgenda> {
  List<Map<String, dynamic>> tarefas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Minha Agenda",
          style: TextStyle(
            fontFamily: 'LoveDays',
            fontSize: 24,
          ),
        ),
      ),

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
                    leading: Checkbox(
                      value: tarefas[index]["concluida"],
                      onChanged: (value) {
                        setState(() {
                          tarefas[index]["concluida"] = value;
                        });
                      },
                    ),

                    title: Text(
                      tarefas[index]["titulo"],
                      style: TextStyle(
                        decoration: tarefas[index]["concluida"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    //  MOSTRAR DATA
                    subtitle: Text(
                      tarefas[index]["data"] != null
                          ? "${tarefas[index]["data"].day}/${tarefas[index]["data"].month}/${tarefas[index]["data"].year}"
                          : "Sem data",
                    ),
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

          // 
          if (novaTarefa != null) {
            setState(() {
              tarefas.add({
                "titulo": novaTarefa["titulo"],
                "data": novaTarefa["data"],
                "concluida": false
              });
            });
          }
        },
      ),
    );
  }
}