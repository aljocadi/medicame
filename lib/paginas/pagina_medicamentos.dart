import 'package:flutter/material.dart';
import 'package:medicame/paginas/pagina_medicamento.dart';
import 'package:medicame/tema/tema.dart';
import 'package:provider/provider.dart';

class PaginaMedicamentos extends StatelessWidget {
  const PaginaMedicamentos({super.key});

  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context);
    return Scaffold(
     appBar: AppBar(
        title: Text('Medicamento',
            style: TextStyle(
              color: temaActual.temaActual.colorScheme.onPrimary,
            )),
        //configuramos el color de fondo
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: temaActual.temaActual.colorScheme.primary,
          ),
        ),
        //configuramos el color de los iconos
        iconTheme: IconThemeData(
          color: temaActual.temaActual.colorScheme.onPrimary,
        ),
      ),
      body: Text('Medicamentos'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaginaMedicamento(),
            ),
          );
        },
        child: Icon(Icons.add),
      )
    );
  }
}