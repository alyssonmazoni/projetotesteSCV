import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String consulta = '';
  String consultaValeu = '';
  var tc1 = TextEditingController();
  var tc2 = TextEditingController();
  var tc3 = TextEditingController();
  var tc4 = TextEditingController();
  int nbd = 0;

  Future<Database> get aula_bd async {
    return openDatabase(join(await getDatabasesPath(), 'aula_bd7.db'),
        onCreate: (baseDeDados, version) {baseDeDados.execute(
            'CREATE TABLE tabela4(id INTEGER PRIMARY KEY, nome TEXT, valor INTEGER)'
        );
        },
        version: 1);
  }

  void _insert(String n, String v) async {
    Database banco = await aula_bd;

    var dado = {//'id': nbd,
      'nome' : n,
      'valor' : int.parse(v)};

    await banco.insert('tabela4', dado,
        conflictAlgorithm: ConflictAlgorithm.replace);

  nbd++;

  }

/*
  void _contarLinhas () async {

    var nrows = 0;
    setState(() {
      var nrows = await banco.rawQuery('SELECT COUNT(*) FROM tabela3');
    });

  }
*/



  void _query(String ind) async {
    Database banco = await aula_bd;

    //int sid = int.parse(ind); //converter string para int parse
    String sid = ind; //converter string para int parse

    //var lista = await banco.query('tabela3');

    //var lista = await banco.query('tabela4', where: 'id = ?', whereArgs: [sid],);
    var lista = await banco.query('tabela4', where: 'nome = ?', whereArgs: [sid],);
    //var listaValue = await banco.query('tabela4', where: 'valor = ?', whereArgs: [sid],);

    int rows = lista.length;
    //int rowsValue = listaValue.length;

    print(await getDatabasesPath());

    setState(() {
      //consulta = lista[sid]['nome'].toString() + lista[sid]['valor'].toString();

      consultaValue = rowsValue;

      consulta = lista[rows-1]['id'].toString()
          + ' '
          + lista[rows-1]['nome'].toString()
          + ' '
          + lista[rows-1]['valor'].toString();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: tc1),
            TextField(controller: tc2),
            RaisedButton(
              child: Text('Inserir'),
              onPressed: () {_insert(tc1.text,tc2.text);},
            ),
            RaisedButton(
              child: Text('Consultar'),
              onPressed: () {_query(tc3.text);},
            ),
            Text(consulta,
            ),
            TextField(controller: tc3),
            TextField(controller: tc4),
          ],
        ),
      ),
    );
  }
}