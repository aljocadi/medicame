import 'package:flutter/material.dart';
import 'package:medicame/modelos/base_datos.dart';
import 'package:medicame/modelos/configuracion.dart';
import 'package:medicame/modo/modo_trabajo.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VisitaMedica{
  int? _id;
  late String _especialidad;
  late String _doctor;
  late String _lugar;
  late DateTime _fecha;
  late String _dia;
  late String _hora;

  //Constructor de la clase
  VisitaMedica()
  {
    this._id = 0;
    this._especialidad = '';
    this._doctor = '';
    this._lugar = '';
    this._fecha = DateTime.now();
    this._dia=this._fecha.day.toString()+'/'+this._fecha.month.toString()+'/'+this._fecha.year.toString();
    this._hora = this._fecha.hour.toString()+':'+this._fecha.minute.toString();
  }
  
  //Constructores con parametros
  VisitaMedica.withOutId(String especialidad, String doctor, String lugar, DateTime fecha)
  {
    this._especialidad = especialidad;
    this._doctor = doctor;
    this._lugar = lugar;
    this._fecha = fecha;
    this._dia=this._fecha.day.toString()+'/'+this._fecha.month.toString()+'/'+this._fecha.year.toString();
    this._hora = this._fecha.hour.toString()+':'+this._fecha.minute.toString();
  }
  
  VisitaMedica.withId(int id, String especialidad, String doctor, String lugar, DateTime fecha)
  {
    this._id = id;
    this._especialidad = especialidad;
    this._doctor = doctor;
    this._lugar = lugar;
    this._fecha = fecha;
    this._dia=this._fecha.day.toString()+'/'+this._fecha.month.toString()+'/'+this._fecha.year.toString();
    this._hora = this._fecha.hour.toString()+':'+this._fecha.minute.toString();
  }

  VisitaMedica.fromMap(dynamic obj)
  {
    this._id = obj['id'];
    this._especialidad = obj['especialidad'];
    this._doctor = obj['doctor'];
    this._lugar = obj['lugar'];
    this._fecha = DateTime.parse(obj['fecha']);
    this._dia=this._fecha.day.toString()+'/'+this._fecha.month.toString()+'/'+this._fecha.year.toString();
    this._hora = this._fecha.hour.toString()+':'+this._fecha.minute.toString();

  }

  //Getters
  int? get id => _id;
  String get especialidad => _especialidad;
  String get doctor => _doctor;
  String get lugar => _lugar;
  DateTime get fecha => _fecha;
  String get dia => _dia;
  String get hora => _hora;
  
  //Setters
  set especialidad(String especialidad)
  {
    this._especialidad = especialidad;
  }
  set doctor(String doctor)
  {
    this._doctor = doctor;
  }
  set lugar(String lugar)
  {
    this._lugar = lugar;
  }
  set fecha(DateTime fecha)
  {
    this._fecha = fecha;
    this._dia=this._fecha.day.toString()+'/'+this._fecha.month.toString()+'/'+this._fecha.year.toString();
    this._hora = this._fecha.hour.toString()+':'+this._fecha.minute.toString();
  }
  set dia(String dia)
  {
    this._dia = dia;
    List<String> partes = dia.split("/");
    int dd = int.tryParse(partes[0])!;
    int mm = int.tryParse(partes[1])!;
    int yyyy = int.tryParse(partes[2])!;
    this._fecha = new DateTime(yyyy, mm, dd, this._fecha.hour, this._fecha.minute);
  }
  set hora(String hora)
  {
    this._hora = hora;
    List<String> partes = hora.split(":");
    int horas = int.tryParse(partes[0])!;
    int minutos = int.tryParse(partes[1])!;
    this.fecha = new DateTime(this._fecha.year, this._fecha.month, this._fecha.day, horas, minutos);
  }

  Future<List<VisitaMedica>> GeTProximasVisitas(bool modoLocal)
  async{
    List<VisitaMedica> proximasVisitas = [];
    VisitaMedica visitaMedica = new VisitaMedica();
    DateTime fechaActual = DateTime.now();
    
    //Si el modo de trabajo es local, se cargan los datos de la base de datos local
    if(modoLocal)
    {
      BDHelper bdHelper = BDHelper();
      List<Map<String, dynamic>> visitas = await bdHelper.consultarBD('VisitaMedica');
      for(int i=0; i<visitas.length; i++)
      {
        DateTime fechaVisita = DateTime.parse(visitas[i]['fecha']);
        if(fechaVisita.isAfter(fechaActual))
        {
          visitaMedica = VisitaMedica.fromMap(visitas[i]);
          proximasVisitas.add(visitaMedica);
        }
      }
    }
    else
    {
      //Si el modo de trabajo es remoto, se cargan los datos de la API
      proximasVisitas = await _getFromAPI();
    }
    
    return proximasVisitas;
  }

  //lectura de datos de la API
  Future<List<VisitaMedica>> _getFromAPI() async {
    final response = await http.get(Uri.parse('http://10.171.167.222:5000/api/visita'));
    if (response.statusCode == 200) {
      List<VisitaMedica> lista = [];
      VisitaMedica visitaMedica = new VisitaMedica();
      var data = json.decode(response.body);
      for(int i=0;i<data.length;i++)
      {
        print(data[i]);
        visitaMedica = VisitaMedica.fromMap(data[i]);
        lista.add(visitaMedica);
      }
      return lista;
    } else {
      throw Exception('Error al leer datos de la API');
    }
    // List<VisitaMedica> lista = [];
    // VisitaMedica visitaMedica = new VisitaMedica();
    // var map = new Map<String, dynamic>();
    
    // for(int i=0;i<numero;i++)
    // {
    //   await Future.delayed(Duration(milliseconds: 200), () {
    //     map['id'] = i;
    //     map['especialidad'] = 'Especialidad '+i.toString();
    //     map['doctor'] = 'Doctor '+i.toString();
    //     map['lugar'] = 'Lugar '+i.toString();
    //     map['fecha'] = DateTime.now().toString();
    //     visitaMedica = VisitaMedica.fromMap(map);
    //     lista.add(visitaMedica);
    //   });
    // }
    // return lista;
  }

  //Metodo para convertir un objeto de tipo VisitaMedica a Map
  Map<String, dynamic> toMap()
  {
    var map = new Map<String, dynamic>();
    if((id != null && id != 0))
    {
      map['id'] = _id;
    }
    map['especialidad'] = _especialidad;
    map['doctor'] = _doctor;
    map['lugar'] = _lugar;
    map['fecha'] = _fecha.toString();
    return map;
  }

}