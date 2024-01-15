
import 'package:flutter/material.dart';
import 'package:medicame/tema/tema.dart';
import 'package:provider/provider.dart';
import 'package:medicame/modelos/medicamento.dart';

class PaginaMedicamento extends StatefulWidget {
  const PaginaMedicamento({super.key});

  @override
  State<PaginaMedicamento> createState() => _PaginaMedicamentoState();
}

class _PaginaMedicamentoState extends State<PaginaMedicamento> {
  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context).temaActual;
    final _formKey = GlobalKey<FormState>();

    Medicamento medicamento=Medicamento();
    return Scaffold(
     appBar: AppBar(
        title: Text('Medicamento',
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
      //body para crear un formulario recoger los datos de un medicamento
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
             //Descripcion de seccion
              ListTile(
                title: Text(
                  "Datos generales",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: temaActual.colorScheme.onSecondary,
                  ),
                ),
                tileColor: temaActual.colorScheme.secondary,
              ),
              //Campo de texto para el nombre del medicamento
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    hintText: 'Introduce el nombre del medicamento',
                    icon: Icon(Icons.medication),
                  ),
                  //validador que actuará cuando se pulse el botón de guardar
                  validator: (valor)  {
                    if (valor==null || valor.isEmpty) {
                      return 'Por favor, introduce el nombre del medicamento';
                    }
                    return null;
                  },
                  //Cuando se cambie el valor del campo de texto se actualiza el nombre del medicamento
                  onSaved: (valor) {
                    if(valor!=null){
                      medicamento.nombre = valor;
                    } 
                  },
                ),
              ),
              // //Campo de texto para la descripcion del medicamento
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Descripcion',
                    hintText: 'Introduce la descripción del medicamento',
                    icon: Icon(Icons.textsms),
                  ),
                  //validador que actuará cuando se pulse el botón de guardar
                  validator: (valor)  {
                    if (valor==null || valor.isEmpty) {
                      return 'Por favor, introduce la descripcion del medicamento';
                    }
                    return null;
                  },
                  //Cuando se cambie el valor del campo de texto se actualiza la dosis del medicamento
                  onSaved: (valor) {
                    if(valor!=null)
                     {medicamento.descripcion = valor;}
                  },
                ),
              ),
              //separador
              Divider(
                color: temaActual.colorScheme.primary,
              ),
              
              ListTile(
                title: Text(
                  "Imagenes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: temaActual.colorScheme.onSecondary,
                  ),
                ),
                tileColor: temaActual.colorScheme.secondary,
              ),

              // Imagenes del medicamento
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Medicamento",
                      style: TextStyle(
                        color: temaActual.colorScheme.onSecondary,
                      ),
                    ),
                    IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {}),
                    Text(
                      "Envase",
                      style: TextStyle(
                        color: temaActual.colorScheme.onSecondary,
                      ),
                    ),
                    IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {}),
                  ],
                ),
              ),

              Divider(
                color: temaActual.colorScheme.primary,
              ),
              //Cantidad Inicial del medicamento
              ListTile(
                title: Text(
                  "Cantidades",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: temaActual.colorScheme.onSecondary,
                  ),
                ),
                tileColor: temaActual.colorScheme.secondary,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    //Campo de texto para la cantidad actual del medicamento
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Cantidad actual',
                          hintText: 'Introduce la cantidad actual del medicamento',
                          icon: Icon(Icons.battery_3_bar),
                        ),
                        keyboardType: TextInputType.number,
                        //validador que actuará cuando se pulse el botón de guardar
                        validator: (valor)  {
                          if (valor==null || valor.isEmpty) {
                            return 'Por favor, introduce la cantidad actual del medicamento';
                          }
                          return null;
                        },
                        //Cuando se cambie el valor del campo de texto se actualiza la cantidad inicial del medicamento
                        onSaved: (valor) {
                          if(valor!=null)
                          {
                            medicamento.cantidadActual = int.parse(valor);
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: const  InputDecoration(
                          labelText: 'Cantidad por envase',
                          hintText: 'Introduce la cantidad por envase',
                          icon: Icon(Icons.battery_full),
                        ),
                        keyboardType: TextInputType.number,
                        //validador que actuará cuando se pulse el botón de guardar
                        validator: (valor)  {
                          if (valor==null || valor.isEmpty) {
                            return 'Por favor, introduce la cantidad por envase del medicamento';
                          }
                          return null;
                        },
                        //Cuando se cambie el valor del campo de texto se actualiza la cantidad actual del medicamento
                        onSaved: (valor) {
                          if(valor!=null)
                          {
                            //hemos comprobado que el valor no es nulo, pero puede que no sea un numero
                              int? cActual = int.tryParse(valor);
                            medicamento.cantidadActual = (cActual==null)?0:cActual;
                          }
                          
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Cantidad minima',
                          hintText: 'Introduce la cantidad minima del medicamento',
                          icon: Icon(Icons.battery_0_bar),
                        ),
                        keyboardType: TextInputType.number,
                        //validador que actuará cuando se pulse el botón de guardar
                        validator: (valor)  {
                          if (valor==null || valor.isEmpty) {
                            return 'Por favor, introduce la cantidad minima del medicamento';
                          }
                          return null;
                        },
                        //Cuando se cambie el valor del campo de texto se actualiza la cantidad actual del medicamento
                        onSaved: (valor) {
                          if(valor!=null)
                          {
                            //hemos comprobado que el valor no es nulo, pero puede que no sea un numero
                            int? cMinima = int.tryParse(valor);
                            medicamento.cantidadMinima = (cMinima==null)?0:cMinima;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
               Divider(
                color: temaActual.colorScheme.primary,
              ),
              ListTile(
                title: Text(
                  "Preescipción",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: temaActual.colorScheme.onSecondary,
                  ),
                ),
                tileColor: temaActual.colorScheme.secondary,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    //Campo de texto para la dosis del medicamento
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Dosis',
                          hintText: 'Introduce la cantidad en cada toma',
                          icon: Icon(Icons.add),
                        ),
                        keyboardType: TextInputType.number,
                        //validador que actuará cuando se pulse el botón de guardar
                        validator: (valor)  {
                          if (valor==null || valor.isEmpty) {
                            return 'Por favor, introduce la cantidad en cada toma';
                          }
                          return null;
                        },
                        //Cuando se cambie el valor del campo de texto se actualiza la cantidad inicial del medicamento
                        onSaved: (valor) {
                          if(valor!=null)
                            {
                              //hemos comprobado que el valor no es nulo, pero puede que no sea un numero
                              int? dosis = int.tryParse(valor);
                              medicamento.dosis = (dosis==null)?0:dosis;
                            }
                        },
                      ),
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Frecuencia',
                          hintText: 'Introduce la frecuencia de tomas',
                          icon: Icon(Icons.timer),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 8,
                            child: Text("3 veces al día"),
                          ),
                          DropdownMenuItem(
                            value: 24,
                            child: Text("1 veces al día"),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text("Cada hora"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("Cada 2 horas"),
                          ),
                          DropdownMenuItem(
                            value: 12,
                            child: Text("Cada 12 horas"),
                          ),
                        ],
                        onChanged: (value) {
                          if(value!=null)
                          {
                            medicamento.frecuencia = value;
                          }
                        },
                        onSaved: (value) {
                          if(value!=null)
                          {
                            medicamento.frecuencia = value;
                          }
                          else
                          {
                            medicamento.frecuencia = 0;
                          }
                        
                        },
                      )
                    ),
                  ],
                ),
              ),
              
              Divider(
                color: temaActual.colorScheme.primary,
              ),
              //Estado
              ListTile(
                title: Text(
                  "Estado",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: temaActual.colorScheme.onSecondary,
                  ),
                ),
                tileColor: temaActual.colorScheme.secondary,
              ),
              //Campo de texto para la frecuencia del medicamento
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CheckboxListTile(
                  title: Text(
                    "Activo",
                    style: TextStyle(
                      color: temaActual.colorScheme.onPrimary,
                    ),
                  ),
                  value: medicamento.activo, 
                  onChanged: (_) {
                    setState(() {
                      medicamento.activo = !medicamento.activo;
                    });
                  }),
              ),
              Divider(
                color: temaActual.colorScheme.primary,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Aquí puedes utilizar _medicamento para guardar los datos
                      // en tu base de datos o realizar alguna otra acción.
                    }
                  },
                  child: const Text('Guardar'),
                ),
          ]),
        ),
      )
    );
  }
}