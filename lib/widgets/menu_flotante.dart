import 'package:flutter/material.dart';
import 'package:medicame/tema/tema.dart';
import 'package:provider/provider.dart';

class MenuFlotante extends StatelessWidget {
  final bool mostrar;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<BotonMenuFlotante> items;

  MenuFlotante({
    this.mostrar=true, 
    this.backgroundColor=Colors.white, 
    this.activeColor=Colors.blue, 
    this.inactiveColor=Colors.grey,
    required this.items,  });

  // final List<BotonMenuFlotante> items=[
  //   BotonMenuFlotante(icono: Icons.pie_chart, onPressed: (){print('pie_chart');}),
  //   BotonMenuFlotante(icono: Icons.search, onPressed: (){print('buscar');}),
  //   BotonMenuFlotante(icono: Icons.notifications, onPressed: (){print('notifications');}),
  //   BotonMenuFlotante(icono: Icons.supervised_user_circle, onPressed: (){print('supevised');}),
  // ];

  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _MenuModel(),
      child: AnimatedOpacity(
        opacity: (mostrar)?1:0,
        duration: const Duration(milliseconds: 250),
        child: Builder(
          builder: (BuildContext context) {
            Provider.of<_MenuModel>(context).backgroundColor=this.backgroundColor;
            Provider.of<_MenuModel>(context).activeColor=this.activeColor;
            Provider.of<_MenuModel>(context).inactiveColor=this.inactiveColor;
            return _MenuFlotanteFondo(
                    child: _MenuItems(items)
                    );
          },
      ),
      ),
    );
  }
}

///Clase que representa el widget del fondo del menu flotante
class _MenuFlotanteFondo extends StatelessWidget {
  final Widget child;
  
  const _MenuFlotanteFondo({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor=Provider.of<_MenuModel>(context).backgroundColor;
    return Container(
      child: this.child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5,
          ),
        ],
      ),
    );
  }
}

///Clase que representa el widget de la fila de botones del menu flotante
class _MenuItems extends StatelessWidget {
  final List<BotonMenuFlotante> menuItems;
  _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (index) => _BotonFisicoMenu(index,menuItems[index])),
    );
  }
}

///Clase que representa el widget de un boton del menu flotante
class _BotonFisicoMenu extends StatelessWidget {
  final int index;
  final BotonMenuFlotante item;
  
  _BotonFisicoMenu(this.index,this.item);

  @override
  Widget build(BuildContext context) {
    final menuModel = Provider.of<_MenuModel>(context);
    //recogemos del provider el elemento seleccionado
    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;
    return GestureDetector(
      onTap: (){
        //cambiamos el elemento seleccionado en el provider
        Provider.of<_MenuModel>(context,listen: false).itemSeleccionado=index;
        item.onPressed!();
      },
      //esto es necesario porque si el GestureDetector no funciona
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icono,
          //depemdiendo de si el elemento esta seleccionado o no cambiamos el tamaño y el color
          size: (itemSeleccionado==index)?35:25,
          color: (itemSeleccionado==index)?menuModel.activeColor:menuModel.inactiveColor,
          ),
      ),
    );
  }
}


/// Clase que representa un boton del menu flotante, en el que se puede definir el texto, el icono y la funcion que se ejecuta al pulsar
class BotonMenuFlotante{
  final String? texto;
  final IconData icono;
  final Function()? onPressed;

  BotonMenuFlotante({
    this.texto,
    required this.icono,
    required this.onPressed,
  });
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = 0;
  Color backgroundColor=Colors.white;
  Color activeColor=Colors.blue;
  Color inactiveColor=Colors.grey;
  
  int get itemSeleccionado => this._itemSeleccionado;

  set itemSeleccionado(int index) {
    this._itemSeleccionado = index;
    notifyListeners();
  }
}
