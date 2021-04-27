

import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




void main() async {

  runApp(MeuApp());

}

class MeuApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Catalogo(),
    );
  }
}

class Catalogo extends StatefulWidget {

  @override
  _CatalogoState createState() => _CatalogoState();
}


class _CatalogoState extends State<Catalogo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Carros")
      ),
      body: Center(


      ),



      //body: ListWheelScrollView(
        //children: <Widget>[
          //CardCarro(),
          //CardCarro(),
          //CardCarro(),
          //CardCarro(),
          //CardCarro(),
          //CardCarro(),
          //CardCarro(),
          //CardCarro(),
          //CardCarro(),
        //],
        //itemExtent: 150,
        //diameterRatio: 6,
        //offAxisFraction: 0,
        ////useMagnifier: true,
        //magnification: 1.5,
      //),



      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.directions_car),
          backgroundColor: Colors.blueAccent,
          onPressed: ()=> print(''),

      ),
    );//
  }
}



class CardCarro extends StatefulWidget {
  @override
  _CardCarro createState() => _CardCarro();
}

class _CardCarro extends State<CardCarro> {

  String carname = "";
  int caryear = 0;
  String carfactory = "";
  String carowner = "";


  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(5),
      child: Card(color: Colors.white70,
              elevation: 5,
              margin: EdgeInsets.all(5),
              child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget> [

                        Expanded(
                          flex: 5,
                          child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(padding: EdgeInsets.all(5),
                                        child: Image.asset('assets/ShelbyCobra.jpeg',
                                                width: 150,
                                                height: 100,
                                                fit: BoxFit.fitHeight

                                        ),
                                      ),
                                      Text("Shelby Cobra")
                                    ],
                                  )
                        ),

                        Expanded(
                          flex: 4,
                          child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      textDirection: TextDirection.ltr,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("year: 1967", textDirection: TextDirection.ltr),
                                        Text("factory: Ford"),
                                        Text("owner: Ferretti")
                                      ],
                                    ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FlatButton.icon(onPressed: ()=> print("comente"),
                                  icon: Icon(Icons.add_comment,
                                          color: Colors.blueAccent),
                                  label: Text("")
                              ),
                              FlatButton.icon(onPressed: ()=> print("adiciona foto"),
                                  icon: Icon(Icons.add_a_photo,
                                    color: Colors.blueAccent),
                                  label: Text("")
                              ),
                            ]),

                        )

                      ]
                    )
              )
    );
  }
}


