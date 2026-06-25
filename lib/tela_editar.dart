import 'package:flutter/material.dart';

class TelaEditar extends StatefulWidget {
  final Map<String, dynamic> tarefa;

  TelaEditar({required this.tarefa});

  @override
  _TelaEditarState createState() => _TelaEditarState();
}

class _TelaEditarState extends State<TelaEditar> {
  late TextEditingController controller;
  DateTime? dataSelecionada;

  @override
  void initState() {
    super.initState();

  
    controller = TextEditingController(text: widget.tarefa["titulo"]);
    dataSelecionada = widget.tarefa["data"];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Tarefa"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Editar tarefa",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Selecionar nova data"),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: dataSelecionada ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  setState(() {
                    dataSelecionada = picked;
                  });
                }
              },
            ),

            SizedBox(height: 10),

            Text(
              dataSelecionada == null
                  ? "Nenhuma data escolhida"
                  : "Data: ${dataSelecionada!.day}/${dataSelecionada!.month}/${dataSelecionada!.year}",
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Salvar alterações"),
              onPressed: () {
                if (controller.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Digite uma tarefa")),
                  );
                  return;
                }

                Navigator.pop(context, {
                  "titulo": controller.text,
                  "data": dataSelecionada
                });
              },
            )
          ],
        ),
      ),
    );
  }
}