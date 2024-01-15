import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cabecera extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String subtitulo;
  final Color colorIcono;
  final Color colorTitulo;
  final Color colorFondo1;
  final Color colorFondo2;

  const Cabecera({
    super.key, 
    required this.icono, 
    required this.titulo, 
    required this.subtitulo, 
    required this.colorIcono, 
    required this.colorTitulo, 
    this.colorFondo1=const Color(0xFF526BF6), 
    this.colorFondo2=const Color(0xFF67ACF2)});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _FondoCabecera(color1: colorFondo1,color2: colorFondo2,),
        Positioned(
          top: -90,
          left: -40,
          child: FaIcon(icono, size: 250,color: colorIcono,)
          ),
          Column(
            children: <Widget>
            [
              SizedBox(height: 70,width: double.infinity,),
              Text(titulo, style: TextStyle(color: colorTitulo, fontSize: 30, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(subtitulo, style: TextStyle(color: colorTitulo, fontSize: 18),),
              SizedBox(height: 10,),
              FaIcon(icono,size:80, color: colorTitulo,)
            ],
          ),
        ],
      );
  }
}

class _FondoCabecera extends StatelessWidget {
  final Color color1;
  final Color color2;
  const _FondoCabecera({
    super.key, 
    required this.color1, 
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration
      (
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        gradient: LinearGradient
        (
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>
          [
            this.color1,
            this.color2,
          ]
        )
      )
    );
  }
}