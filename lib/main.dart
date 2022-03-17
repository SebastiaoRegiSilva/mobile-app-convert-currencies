import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Uso da API para conversão de moedas estrangeiras para real.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _siglaUm = TextEditingController();
  TextEditingController _siglaDois = TextEditingController();

  String _moeda = "";
  String _precoDolar = "0";
  _buscaPreco() async {
    String urlAPI = "https://economia.awesomeapi.com.br/json/last/" + _siglaUm.text + "-" + _siglaDois.text;
    http.Response response;
    response = await http.get(urlAPI);
    Map<String, dynamic> retorno = json.decode(response.body);
    //print(_siglaDois);
    //print(_siglaUm);
    //print(retorno[_siglaUm.text + _siglaDois.text]["high"].toString());
    setState(() {
      _precoDolar = retorno[_siglaUm.text + _siglaDois.text]["high"].toString();
      _moeda = _siglaUm.text + "/" + _siglaDois.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.monetization_on, size: 100.0, color: Colors.black87),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                maxLength: 3,
                controller: _siglaUm,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Digite a sigla da Primeira Moeda",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextField(
                maxLength: 3,
                controller: _siglaDois,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Digite a sigla da Segunda Moeda",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                "A conversão " + _moeda + " equivale à: R\$" + _precoDolar,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            RaisedButton(
                color: Colors.orange,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Text("Converter",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
                onPressed: _buscaPreco)
          ],
        ),
      ),
    ));
  }
}
