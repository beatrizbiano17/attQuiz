import 'package:flutter/material.dart';

class TelaAdicionar extends StatefulWidget {
  @override
  _TelaAdicionarState createState() => _TelaAdicionarState();
}

class _TelaAdicionarState extends State<TelaAdicionar> {

  final TextEditingController controller = TextEditingController();
  DateTime? dataSelecionada;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Tarefa"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Digite a tarefa",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Selecionar data"),
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
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
              child: Text("Salvar"),
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