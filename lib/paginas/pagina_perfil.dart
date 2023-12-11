import 'package:flutter/material.dart';
import 'package:medicame/tema/tema.dart';
import 'package:provider/provider.dart';

class PaginaPerfil extends StatelessWidget {
  const PaginaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil',
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
      body: Center(
        child: Text('Perfil'),
      ),);
  }
}