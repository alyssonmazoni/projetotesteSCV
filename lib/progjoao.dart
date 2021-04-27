import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(new MaterialApp(
  home: new Home(),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String consulta = '';
  var tc1 = TextEditingController();
  var tc2 = TextEditingController();
  var tc3 = TextEditingController();
  int nbd = 0;

  Future<Database> get aula_bd async {
    return openDatabase(join(await getDatabasesPath(), 'aula_bd6.db'),
        onCreate: (baseDeDados, version) {
          baseDeDados.execute(
              'CREATE TABLE tabela4(id INTEGER PRIMARY KEY, nome TEXT, valor INTEGER)');
        }, version: 1);
  }

  void _insert(String n, String v) async {
    Database banco = await aula_bd;

    var dado = {
      //'id': nbd,
      'nome': n,
      'valor': int.parse(v)};

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

    int sid = int.parse(ind); //converter string para int parse

    //var lista = await banco.query('tabela3');

    var lista = await banco.query(
      'tabela4',
      where: 'id = ?',
      whereArgs: [sid],
    );

    int rows = lista.length;

    setState(() {
      //consulta = lista[sid]['nome'].toString() + lista[sid]['valor'].toString();
      consulta = lista[rows - 1]['id'].toString() +
          lista[rows - 1]['nome'].toString() +
          lista[rows - 1]['valor'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.refresh),
        title: Text('BANCO DE DADOS'),
        centerTitle: true, //CENTRALIZAR TEXTO
        backgroundColor: Colors.blue,

        //COR APP BAR
      ),
      body: Container(
        color: Colors.grey, //COR DE FUNDO
        alignment: Alignment.topCenter,
        child: ListView(
          //ROLA CIMA BAIXO
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            /*Image.asset(
                'assets/imc.png',
              height: 75.0,//DIMENSÕES LOGO
              width: 65.0,//DIMENSÕES LOGO
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                // height: 245.0,
                //width: 290.0,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number, //TIPO DE TECLADO
                        controller: tc1,
                        decoration: InputDecoration(
                            labelText: 'Nome', //TEXTO
                            hintText: 'String', // DICA DO TEXTO
                            icon: Icon(Icons.assignment_turned_in_sharp)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.name, //TIPO DE TECLADO
                        controller: tc2, //_alturaControl,
                        decoration: InputDecoration(
                            labelText: 'Valor', //TEXTO
                            hintText: 'Int', // DICA DO TEXTO
                            icon: Icon(Icons.person_outline)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number, //TIPO DE TECLADO
                        controller: tc3, //_pesoControl,
                        decoration: InputDecoration(
                            labelText: 'Consultar', //TEXTO
                            hintText: 'Int', // DICA DO TEXTO
                            icon: Icon(Icons.line_weight)),
                      ),
                    ),
                    //BOTÃO
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: RaisedButton(
                          onPressed: () {
                            _insert(tc1.text, tc2.text);
                          }, //_calcularIMC,
                          color: Colors.blue,
                          child: Text('Inserir'),
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child:
                        ElevatedButton(
                          onPressed: () {
                            _query(tc3.text);
                          },
                          child: Text('Consultar'),
                          style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.pinkAccent),

                                ),
                          ),
                        ),
                      ),

                    Text(
                      consulta,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "1",
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontSize: 19.9),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "2",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        fontSize: 19.9),
                  ),
                ),
                Text(
                  consulta,)
              ],
            )
          ],
        ),
      ),
    );
  }
}