import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  //abrir o banco de dados e restaurar referencia

  //database instancia um openDatabase que eu chamei no path
  final Future<Database> database = openDatabase(

    join(await getDatabasesPath(), 'banco_cars.db'),

    //se o banco não foi criado quando eu chamo, eu crio
    onCreate: (db,version) {

        return db.execute(
          "CREATE TABLE tabcar(placa String PRIMARY KEY, ano int, marca String, modelo String)",
        );
      },
      version: 1,
  );


//retorno simples de uma tabela
  Future cars() async {
  //busquei o banco
    final Database db = await database;
  //fiz um select na tabela
    final maps = await db.query('tabcar');
  //retornei a info
    return maps;
  }


  
//retorno de uma lista
  Future<List<Car>> listCars() async {
    //busquei o banco
    final Database db = await database;
    //fiz um select na tabela
    final List<Map<String, dynamic>> maps = await db.query('tabcar');
    //retornei a info
    return List.generate(maps.length, (i) {
      return Car(
        placa: maps[i]['placa'],
        ano: maps[i]['ano'],
        marca: maps[i]['marca'],
        modelo: maps[i]['modelo'],
      );
    });
  }



//Update
  Future<void> updateCar(Car car) async {
    final Database db = await database;
    await db.update(
        'tabcar',
        car.toMap(),
        where: "placa = ?",
        whereArgs: [car.placa],
        );
  }


  //Delete
  //Future <void> deleteCar(Car car) async {  //pode ser assim ou abaixo
  Future <void> deleteCar(String placa) async {
    final Database db = await database;

    await db.delete(
      'tabcar',
      where: 'placa = ?',
      //whereArgs: [car.placa],  //pode ser assim, ou abaixo
      whereArgs: [placa],
    );
  }


//função para inserir carro
  Future<void> insertCar(Car car) async {

    //instancio o banco com a variavel db
    final Database db = await database;

    await db.insert(
      'tabcar',
      car.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }


//Variavel criada de um carro
  final stude51Pickup = Car(
    placa: 'ABC1111',
    ano: 1951,
    marca: 'Studebaker',
    modelo: 'Pickup E Series'
  );

//Variavel criada de um carro
  final shelbyCobra = Car(
      placa: 'ABC2222',
      ano: 2021,
      marca: 'Ford',
      modelo: 'Shelby Cobra'
  );



await insertCar(stude51Pickup);
await insertCar(shelbyCobra);

//await deleteCar(Car(placa: 'ABC2222'));   //pode ser assim, ou abaixo
//await deleteCar('ABC1111');

/*
  await updateCar(Car(
    placa: 'ABC3333',
    ano: 2050,
    marca: 'GMC',
    modelo: 'Marta Rocha',
  ));
*/

  print(await cars());
  print(await listCars());




} //main


class Car {
  final String placa;
  final int ano;
  final String marca;
  final String modelo;

  Car({this.placa, this.ano, this.marca, this.modelo});


  Map<String, dynamic> toMap() {
    return {
      'placa': placa,
      'ano': ano,
      'marca': marca,
      'modelo': modelo,
    };
  }
}


