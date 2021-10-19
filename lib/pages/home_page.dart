import 'dart:io';

import 'package:contatos/helpers/database_helper.dart';
import 'package:contatos/models/contato.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper db = DatabaseHelper();
  List<Contato> contatos = <Contato>[];

  @override
  void initState() {
    super.initState();

    Contato c = Contato(1, 'fjavier02', 'francisco.lopez@gmail.com',
        'https://avatars.githubusercontent.com/u/72283054?v=4');
    db.insertContato(c);
    Contato c1 = Contato(2, 'genesysrm', 'genesys.merchan@gmail.com',
        'https://avatars.githubusercontent.com/u/54962126?v=4');
    db.insertContato(c1);
    Contato c2 = Contato(3, 'gabrieladias99', 'gabriela.dias@vtex.com.br',
        'https://avatars.githubusercontent.com/u/49461361?v=4');
    db.insertContato(c2);
    Contato c3 = Contato(4, 'Danilsonunes', 'danilsonunes@gmail.com',
        'https://avatars.githubusercontent.com/u/65654455?v=4');
    db.insertContato(c3);
    Contato c4 = Contato(5, 'Rubendvb', 'rubenvasquez556@gmail.com',
        'https://avatars.githubusercontent.com/u/71610449?v=4');
    db.insertContato(c4);
    Contato c5 = Contato(6, 'ncarrillo79', 'ncarrillo79@hotmail.com',
        'https://avatars.githubusercontent.com/u/52607084?v=4');
    db.insertContato(c5);

    db.getContatos().then((lista) {
      print(lista);
    });

/*
  db.getContatos().then((lista) {
      setState(() {
        contatos = lista;
      });
    });

*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("contatos"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: const <Widget>[],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return _listaContatos(context, index);
        },
      ),
    );
  }

  _listaContatos(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          // ignore: unnecessary_null_comparison
                          image: contatos[index].avatar != null
                              ? FileImage(File(contatos[index].avatar))
                              : FileImage(File(contatos[index].avatar))),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(contatos[index].usergh,
                              style: const TextStyle(fontSize: 20)),
                          Text(contatos[index].email,
                              style: const TextStyle(fontSize: 15))
                        ],
                      ))
                ],
              ))),
    );
  }
}
