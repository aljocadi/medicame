
import 'package:flutter/material.dart';
import 'package:medicame/rutas/rutas.dart';
import 'package:medicame/tema/tema.dart';
import 'package:provider/provider.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    
    final temaActual=Provider.of<CargadorTema>(context).temaActual;

    return Scaffold(
      
      //configuramos el appbar
      appBar: AppBar(
        //configuramos el titulo
        title: Text(
          'Medicame',
          style: TextStyle(
            color: temaActual.colorScheme.onPrimary,
          )
        ),
        //configuramos el color de fondo
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: temaActual.colorScheme.primary,
          ),
        ),
        //configuramos el color de los iconos
        iconTheme: IconThemeData(
          color: temaActual.colorScheme.onPrimary,
        ),
      ),
      drawer: _MenuPrincipal(),
      body: const Center(
        child: Text('Página principal'),
      ),
      );
  }
}

class _MenuPrincipal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final temaActual=Provider.of<CargadorTema>(context).temaActual;

    return Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: temaActual.colorScheme.primary,
              ),
              child: CircleAvatar(
                backgroundColor: temaActual.colorScheme.onPrimary,
                child: Text(
                  'AL',
                  style: TextStyle(
                    color: temaActual.colorScheme.primary,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _ListaOpciones(),
          ),
        ]));
  }
}

class _ListaOpciones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final temaActual=Provider.of<CargadorTema>(context).temaActual;
    //construimos un listview con los elementos de la lista de rutas
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Divider(
        color: temaActual.colorScheme.primary,
      ),
      itemCount: rutasPaginas.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(
          rutasPaginas[index].icono,
          color: temaActual.colorScheme.primary,
        ),
        title: Text(
          rutasPaginas[index].titulo,
          style: TextStyle(
            color: temaActual.colorScheme.primary,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => rutasPaginas[index].pagina,
            ),
          );
        },
      ),
    );
  }
}