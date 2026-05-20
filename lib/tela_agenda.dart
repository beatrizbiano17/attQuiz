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
    

        ),
      ),
//mostra mensagem caso não tenha tarefa, caso contrário abre a lista de tarefas//
      body: tarefas.isEmpty
          ? Center(
              child: Text(
                "Nenhuma tarefa ainda",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
            //define quantos itens vai ter na tela//
              itemCount: tarefas.length,
              //monta cada item da lista//
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
            //marca a tarefa//
                    leading: Checkbox(
                      value: tarefas[index]["concluida"],
                      onChanged: (value) {
            //atualiza a tela//
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

                //mostra a data//
                    subtitle: Text(
                //verifca se tem data//
                      tarefas[index]["data"] != null
                          ? "${tarefas[index]["data"].day}/${tarefas[index]["data"].month}/${tarefas[index]["data"].year}"
                          : "Sem data",
                    ),
                  ),
                );
              },
            ),
        //botão de adicionar tarefa//
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //permite usar o await que espera algo acontecer//
        onPressed: () async {
          final novaTarefa = await Navigator.push(
            context,
        //como a nova tela vai abrir e qual tela vai abrir//
            MaterialPageRoute(
              builder: (context) => TelaAdicionar(),
            ),
          );

          //verifica se chegou algum dado//
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