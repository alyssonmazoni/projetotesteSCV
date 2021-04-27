import 'package:flutter/material.dart';
import 'package:flutter_app_teste3/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco de Dados',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;
  final TextEditingController tcNome = TextEditingController();
  final TextEditingController tcIdade = TextEditingController();

  var message = Text("Banco de dados");
  String message1 = "Banco de dados1";

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20),),
              onPressed: () {
                _insert();
              },
            ),
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20),),
              onPressed: () {
                _query();
              },
            ),
            RaisedButton(
              child: Text('update', style: TextStyle(fontSize: 20),),
              onPressed: () {
                _update();
              },
            ),
            RaisedButton(
              child: Text('delete', style: TextStyle(fontSize: 20),),
              onPressed: () {
                _delete();
              },
            ),
            message,  //forma 1 de fazer
            Text(message1),  //forma 2 de fazer
            TextField(controller: tcNome,
            decoration: InputDecoration(labelText: 'nome'),
            ),
            TextField(controller: tcIdade,
            decoration: InputDecoration(labelText: 'Idade'),
            ),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : tcNome.text,
      DatabaseHelper.columnAge  : tcIdade.text,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');

    setState(() {
      message = Text('inserted row id: $id');
      message1 = 'inserted row id: $id';
    });
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
    setState(() {
      message = Text('query all rows:');
      message1 = 'query all rows:';
    });
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mary',
      DatabaseHelper.columnAge  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
    setState(() {
      message = Text('updated $rowsAffected row(s)');
      message1 = 'updated $rowsAffected row(s)';
    });
    }

  void _delete() async {

    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
    setState(() {
      message = Text('deleted $rowsDeleted row(s): row $id');
      message1 = 'deleted $rowsDeleted row(s): row $id';
    });
  }
}