import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicame/modelos/base_datos.dart';
import 'package:medicame/modelos/visita_medica.dart';
import 'package:medicame/modo/modo_trabajo.dart';
import 'package:medicame/paginas/pagina_visita_medica.dart';
import 'package:medicame/widgets/boton_lista_visita.dart';
import 'package:medicame/widgets/header.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class _ItemBoton {

  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;

  _ItemBoton(  this.icon,  this.texto,  this.color1,  this.color2 );
}

class PaginaVisitasMedicas extends StatefulWidget {
  const PaginaVisitasMedicas({super.key});

  @override
  State<PaginaVisitasMedicas> createState() => _PaginaVisitasMedicasState();
}

class _PaginaVisitasMedicasState extends State<PaginaVisitasMedicas> {
  @override
  Widget build(BuildContext context) {
    final VisitaMedica visitaMedica = new VisitaMedica();
    final modoTrabajo=Provider.of<ModoTrabajo>(context);
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            margin: EdgeInsets.only(top: 220),
            child: FutureBuilder(
              future: visitaMedica.GeTProximasVisitas(modoTrabajo.modoLocal),
               builder: (context, AsyncSnapshot<List<VisitaMedica>> snapshot) {
                if(snapshot.hasData)
                {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return BotonListaVisita(icono: FontAwesomeIcons.plus, especialidad: snapshot.data![index].especialidad, lugar:snapshot.data![index].lugar,doctor: snapshot.data![index].doctor,fecha: DateFormat('dd/MM/yyyy HH:mm').format(snapshot.data![index].fecha) , color1:  Color(0xff66A9F2),color2:Color(0xff536CF6) , onPress: (){}, colorTexto: Colors.white.withOpacity(.8),);
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
        //llamada a la pantalla de petición de visita médica y actualización de la lista
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaginaVisitaMedica())).then((value) {
          setState(() {
            
          });
        
        });
        
        
      }, child: Icon(Icons.add),),
      //CabeceraPagina()
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