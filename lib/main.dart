import 'package:flutter/material.dart';
import 'package:medicame/modo/modo_trabajo.dart';
import 'package:medicame/paginas/pagina_principal.dart';
import 'package:medicame/tema/tema.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //Cargamos en el nivel más alto de la aplicación el provider
    //En dicho provider cargamos el tema actual
    MultiProvider(
      providers: [
          ChangeNotifierProvider(
          //cargamos el tema claro por defecto
          create: (_) => CargadorTema(0)),
          ChangeNotifierProvider(
          //cargamos el modo de funcionamiento por defecto
          create: (_) => ModoTrabajo()), 
      ],
      child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    //cargamos el tema actual del provider
    final temaActual=Provider.of<CargadorTema>(context).temaActual;
    
    return MaterialApp(
      title: 'Medicame',
      theme: temaActual,
      home: const PaginaPrincipal(),
    );
  }
}

