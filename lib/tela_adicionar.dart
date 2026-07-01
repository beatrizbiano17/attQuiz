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
      backgroundColor: Color(0xFFEAF3FF),

      appBar: AppBar(
        title: Text(
          "Nova Tarefa",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blueGrey[900]),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20), // 🔥 ajustado pra subir conteúdo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // 📝 CAMPO DE TEXTO
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Digite a tarefa",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 15),

            // 📅 BOTÃO DATA
            ElevatedButton.icon(
              icon: Icon(Icons.calendar_today),
              label: Text("Selecionar data"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6FA8DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
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

            // ✨ ANIMAÇÃO (APARECE SÓ SE TIVER DATA)
            if (dataSelecionada != null)
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: Text(
                  "Data: ${dataSelecionada!.day}/${dataSelecionada!.month}/${dataSelecionada!.year}",
                  key: ValueKey(dataSelecionada),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueGrey[700],
                  ),
                ),
              ),

            SizedBox(height: 15),

            // 💾 BOTÃO SALVAR
            ElevatedButton(
              child: Text("Salvar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6FA8DC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}