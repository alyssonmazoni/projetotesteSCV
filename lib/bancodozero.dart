import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco de Dados',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MeuBanco(),
    );
  }
}

class MeuBanco extends StatefulWidget {
  @override
  _MeuBancoState createState() => _MeuBancoState();
}


class _MeuBancoState extends State<MeuBanco> {

final TextEditingController tcNome = TextEditingController();
final  TextEditingController tcValor = TextEditingController();

String query = '';


Future<Database> get database async {
  return openDatabase(
    join(await getDatabasesPath(), 'dados.db'),
    //join é apenas para colocar a barrinha antes do banco e de acordo com o sistema operacional que tiver.
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE exemplo(id INTEGER PRIMARY KEY, nome TEXT, valor INTEGER)'
      );
    },
    version: 1,
  );
}






void _insertData(String n, String v) async {
  Database db = await database;

  var dado = {
    'id': 0,
    'nome': n,
    'valor': int.parse(v), //converter String em Inteiro
  };

  await db.insert('exemplo', dado,
      conflictAlgorithm: ConflictAlgorithm.replace);


setState(() {

});

}



void _deleteData() {
  setState(() {
    query = '';
    tcNome.clear();
    tcValor.clear();
  });

}



void _updateData() {
  setState(() {
    query = tcNome.text;
  });

}



void _queryData() async {

  Database db = await database;
  var lista = await db.query('exemplo');

  setState(() {
    //query =  lista[0]['nome'];
    query = lista.toString();
  });

}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu Banco")),
      body: Column(
        children: [
          TextField(controller: tcNome,
            decoration: InputDecoration(labelText: "Nome"),
              ),
          TextField(controller: tcValor,
            decoration: InputDecoration(labelText: "Valor"),
              ),
          Text(query),
          Text(''),
          RaisedButton(onPressed: () {_insertData(tcNome.text,tcValor.text);} ,
            child: Text("Insert")),
          RaisedButton(onPressed: _deleteData,
          child: Text("Delete")),
          RaisedButton(onPressed: _queryData,
          child: Text("Consultar")),
          RaisedButton(onPressed: _updateData,
          child: Text("Update")),
      ],
    ),
    );
  }
}
