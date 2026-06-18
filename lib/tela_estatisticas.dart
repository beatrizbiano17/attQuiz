import 'package:flutter/material.dart';

class TelaEstatisticas extends StatelessWidget {
  final List<Map<String, dynamic>> tarefas;

  TelaEstatisticas({required this.tarefas});

  @override
  Widget build(BuildContext context) {

    int total = tarefas.length;
    int concluidas =
        tarefas.where((t) => t["concluida"] == true).length;
    int pendentes = total - concluidas;
    double porcentagem =
        total == 0 ? 0 : (concluidas / total) * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text("Estatísticas"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

         
            _buildCard(
              titulo: "Total de tarefas",
              valor: total.toString(),
              cor: Colors.blue,
            ),

            SizedBox(height: 15),

        
            _buildCard(
              titulo: "Concluídas",
              valor: concluidas.toString(),
              cor: Colors.green,
            ),

            SizedBox(height: 15),

          
            _buildCard(
              titulo: "Pendentes",
              valor: pendentes.toString(),
              cor: Colors.red,
            ),

            SizedBox(height: 30),

       
            Text(
              "Progresso",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            LinearProgressIndicator(
              value: total == 0 ? 0 : concluidas / total,
              minHeight: 10,
            ),

            SizedBox(height: 10),

            Text(
              "${porcentagem.toStringAsFixed(1)}% concluído",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCard({required String titulo, required String valor, required Color cor}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: cor.withOpacity(0.1),
        ),
        child: Column(
          children: [
            Text(
              titulo,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              valor,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: cor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}