import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicame/modelos/base_datos.dart';
import 'package:medicame/paginas/pagina_visita_medica.dart';
import 'package:medicame/widgets/boton_lista.dart';
import 'package:medicame/widgets/header.dart';

class _ItemBoton {

  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;

  _ItemBoton(  this.icon,  this.texto,  this.color1,  this.color2 );
}

class PaginaVisitasMedicas extends StatelessWidget {
  const PaginaVisitasMedicas({super.key});

  @override
  Widget build(BuildContext context) {
    final BDHelper bdHelper = BDHelper();
  
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            margin: EdgeInsets.only(top: 220),
            child: FutureBuilder(
              future: bdHelper.consultarBD('VisitaMedica'),
               builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if(snapshot.hasData)
                {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return BotonLista(icono: FontAwesomeIcons.plus, texto: snapshot.data![index]["especialidad"] , color1:  Color(0xff66A9F2),color2:Color(0xff536CF6) , onPress: (){}, colorTexto: Colors.white.withOpacity(.8),);
                    },
                  );
                }
                else
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
               },
            ),
          ),
          CabeceraPagina(),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaginaVisitaMedica()));
      }, child: Icon(Icons.add),),
      //CabeceraPagina()
    );
  }
}


class BotonListaTemp extends StatelessWidget {
  const BotonListaTemp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BotonLista(
      icono: FontAwesomeIcons.plusMinus,
      texto: 'Agregar Visitas',
      color1: Color(0xFF6989F5),
      color2: Color(0xFF906EF5),
      onPress: () {
        print('Pulsado');
      },
      colorTexto: Colors.white.withOpacity(.8),
    );
  }
}

class CabeceraPagina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Cabecera(
          icono: FontAwesomeIcons.plus,
          titulo: 'Medicame',
          subtitulo: 'Visitas Medicas',
          colorIcono: Colors.white.withOpacity(.2),
          colorTitulo: Colors.white.withOpacity(.8),
          colorFondo1: Color(0xFF526BF6),
          colorFondo2: Color(0xFF67ACF2),
        ),
      
      Positioned(
        right: 0,
        top: 45,
        child: RawMaterialButton
        (
          onPressed: (){},
          shape: CircleBorder(),
          padding: EdgeInsets.all(15.0),
          child: FaIcon(FontAwesomeIcons.ellipsisVertical,color: Colors.white,))
        )
      ],
    );
  }
}