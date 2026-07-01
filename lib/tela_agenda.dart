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
      backgroundColor: Color(0xFFEAF3FF),

      appBar: AppBar(
        title: Text(
          "Minha Agenda",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,

        iconTheme: IconThemeData(
          color: Colors.blueGrey[900],
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart),
            tooltip: "Estatísticas",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      TelaEstatisticas(tarefas: tarefas),
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
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blueGrey,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];

                return AnimatedScale(
                  duration: Duration(milliseconds: 300),
                  scale: tarefa["concluida"] ? 0.96 : 1.0,

                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: ListTile(
                      onTap: () async {
                        final tarefaEditada =
                            await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TelaEditar(
                              tarefa: tarefas[index],
                            ),
                          ),
                        );

                        if (tarefaEditada != null) {
                          setState(() {
                            tarefas[index]["titulo"] =
                                tarefaEditada["titulo"];
                            tarefas[index]["data"] =
                                tarefaEditada["data"];
                          });
                        }
                      },

                      leading: Checkbox(
                        activeColor: Color(0xFF6FA8DC),
                        value: tarefa["concluida"] ?? false,
                        onChanged: (value) {
                          setState(() {
                            tarefa["concluida"] = value;
                          });
                        },
                      ),

                      title: Text(
                        tarefa["titulo"],
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey[900],
                          decoration: tarefa["concluida"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),

                      subtitle: Text(
                        tarefa["data"] != null
                            ? "${tarefa["data"].day}/${tarefa["data"].month}/${tarefa["data"].year}"
                            : "Sem data",
                        style: TextStyle(
                          color: Colors.blueGrey[600],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF6FA8DC),
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