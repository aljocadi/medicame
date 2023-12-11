


import 'package:flutter/material.dart';
import 'package:medicame/paginas/pagina_configuracion.dart';

final rutasPaginas=<_ruta>[
  _ruta(Icons.account_circle, 'Perfil', const Center(child: Text('Perfil'))),
  _ruta(Icons.settings, 'Configuración', PaginaConfiguracion()),
  _ruta(Icons.exit_to_app, 'Salir', const Center(child: Text('Salir'))),
];

class _ruta{
  final IconData icono;
  final String titulo;
  final Widget pagina;

  _ruta(this.icono, this.titulo, this.pagina);
}