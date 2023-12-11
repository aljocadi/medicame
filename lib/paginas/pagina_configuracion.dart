import 'package:flutter/material.dart';
import 'package:medicame/tema/tema.dart';
import 'package:provider/provider.dart';

class PaginaConfiguracion extends StatelessWidget {
  const PaginaConfiguracion({super.key});

  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes',
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
        child: ListView(children: [
          //Sección 1 Ajustes generales
          ListTile(
            title: Text(
              "Ajustes generales",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: temaActual.temaActual.colorScheme.onSecondary,
              ),
            ),
            tileColor: temaActual.temaActual.colorScheme.secondary,
          ),
          //Sección 2 Ajustes de Apariencia
          //separador
          Divider(
            color: temaActual.temaActual.colorScheme.primary,
          ),
          ListTile(
            title: Text(
              "Ajustes de apariencia",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: temaActual.temaActual.colorScheme.onSecondary,
              ),
            ),
            tileColor: temaActual.temaActual.colorScheme.secondary,
          ),
          SwitchListTile(
            title: Text(
              "Tema oscuro",
              style: TextStyle(
                color: temaActual.temaActual.colorScheme.onPrimary,
              ),
            ),
            value: temaActual.temaOscuro,
            onChanged: (value) => temaActual.temaOscuro = value,
          ),
          //Sección 3 Ajustes del tipo de usuario
          Divider(
            color: temaActual.temaActual.colorScheme.primary,
          ),
          ListTile(
            title: Text(
              "Ajustes de usuario",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: temaActual.temaActual.colorScheme.onSecondary,
              ),
            ),
            tileColor: temaActual.temaActual.colorScheme.secondary,
          ),
        ]),
      ),
    );
  }
}
