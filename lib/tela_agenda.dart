import 'package:flutter/material.dart';
import 'tela_adicionar.dart';
import 'tela_estatisticas.dart';
import 'tela_editar.dart';

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
  title: Text("Minha Agenda"),
  centerTitle: true,

  actions: [
    IconButton(
      icon: Icon(Icons.bar_chart),
      tooltip: "Estatísticas",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TelaEstatisticas(
              tarefas: tarefas,
            ),
          ),
        );
      },
    ),
  ],
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
                final tarefa = tarefas[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                 child: ListTile(
                  onTap: () async {
                    final tarefaEditada = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaEditar(
                          tarefa: tarefas[index],
                        ),
                      ),
                    );

                    if (tarefaEditada != null) {
                      setState(() {
                        tarefas[index]["titulo"] = tarefaEditada["titulo"];
                        tarefas[index]["data"] = tarefaEditada["data"];
                });
              }
            },
                              
               
                    leading: Checkbox(
                      value: tarefa["concluida"] ?? false,
                      onChanged: (value) {
                        setState(() {
                          tarefa["concluida"] = value;
                        });
                      },
                    ),

                    // 
                    title: Text(
                      tarefa["titulo"],
                      style: TextStyle(
                        fontSize: 16,
                        decoration: tarefa["concluida"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    
                    subtitle: Text(
                      tarefa["data"] != null
                          ? "${tarefa["data"].day}/${tarefa["data"].month}/${tarefa["data"].year}"
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

          if (novaTarefa != null) {
            setState(() {
              tarefas.add({
                "titulo": novaTarefa["titulo"],
                "data": novaTarefa["data"],
                "concluida": false,
              });
            });
          }
        },
      ),
    );
  }
}