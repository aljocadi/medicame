


import 'package:flutter/material.dart';
import 'package:medicame/paginas/pagina_configuracion.dart';
import 'package:medicame/paginas/pagina_medicamentos.dart';
import 'package:medicame/paginas/pagina_visitas_medicas.dart';

final rutasPaginas=<_ruta>[
  _ruta(Icons.settings, 'Medicamentos', PaginaMedicamentos()),
  _ruta(Icons.account_circle, 'Visitas Médicas', PaginaVisitasMedicas()),
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