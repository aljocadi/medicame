import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:medicame/rutas/rutas.dart';
import 'package:medicame/tema/tema.dart';
import 'package:medicame/widgets/menu_flotante.dart';
import 'package:provider/provider.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context).temaActual;
    
    
    return ChangeNotifierProvider(
      create: (_)=>new _MenuModel(),
      child: Scaffold(
        //configuramos el appbar
        appBar: AppBar(
          //configuramos el titulo
          title: Text('Medicame',
              style: TextStyle(
                color: temaActual.colorScheme.onPrimary,
              )),
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
        body: Stack(
          children: [
            GridAvisos(),
            _LocalizacionMenu(),
          ],
        ),
      ),
    );
  }
}

class _LocalizacionMenu extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context).temaActual;
    final anchoPantalla = MediaQuery.of(context).size.width;
    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    return Positioned(
      child: Container(
        width: anchoPantalla,
        child: Align(
            child: MenuFlotante(
              mostrar: mostrar,
              backgroundColor: temaActual.colorScheme.onPrimary,
              activeColor: temaActual.colorScheme.secondary,
              inactiveColor: temaActual.colorScheme.onTertiary,
              items: [
                BotonMenuFlotante(
                  icono: Icons.add,
                  onPressed: () {
                    print('boton 1');
                  },
                ),
                BotonMenuFlotante(
                  icono: Icons.add,
                  onPressed: () {
                    print('boton 2');
                  },
                ),
                BotonMenuFlotante(
                  icono: Icons.add,
                  onPressed: () {
                    print('boton 3');
                  },
                ),
                BotonMenuFlotante(
                  icono: Icons.add,
                  onPressed: () {
                    print('boton 4');
                  },
                ),
              ],
              )
            ),
      ),
      bottom: 30,
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context).temaActual;

    return Drawer(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
    final temaActual = Provider.of<CargadorTema>(context).temaActual;
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

class GridAvisos extends StatefulWidget {
  GridAvisos({super.key});

  @override
  State<GridAvisos> createState() => _GridAvisosState();
}

class _GridAvisosState extends State<GridAvisos> {
  final List items = List.generate(200, (index) => index);
  //el scrollcontroller nos permitirá saber en que dirección se mueve el scroll
  ScrollController _scrollController = new ScrollController();
  double _scrollAnterior = 0.0;

  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context).temaActual;
    return new StaggeredGridView.countBuilder(
      //asignamos el scrollcontroller al controller de la vista
      controller: _scrollController,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) =>
          _ItemAviso(temaActual: temaActual, index: index),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }

  @override
  void initState() {
    super.initState();
    //añadimos un listener al scrollcontroller, ese lstener es la causa por la que tenemos
    //que hacer stateful este widget
    _scrollController.addListener(() {
      if (_scrollController.offset > _scrollAnterior && _scrollController.offset > 150) {
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
      }
      _scrollAnterior = _scrollController.offset;
    });
  }

  //liberamos el scrollcontroller
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _ItemAviso extends StatelessWidget {
  final int index;

  const _ItemAviso({
    super.key,
    required this.temaActual,
    required this.index,
  });

  final ThemeData temaActual;

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(5),
        decoration: new BoxDecoration(
          color: temaActual.colorScheme.primary,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: new Center(
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Text('$index'),
          ),
        ));
  }
}

class _MenuModel with ChangeNotifier {
  bool _mostrar = true;
  
  Color backgroundColor=Colors.white;
  Color activeColor=Colors.blue;
  Color inactiveColor=Colors.grey;

  bool get mostrar => this._mostrar;

  set mostrar(bool value) {
    this._mostrar = value;
    notifyListeners();
  }
}