import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../main.dart';
import '../widgets/build_text_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const url = "https://api.hgbrasil.com/finance?format=json-cors&key=79602364";

class Conversor extends StatefulWidget {
  const Conversor({super.key});

  @override
  State<Conversor> createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  final TextEditingController realController = TextEditingController();
  final TextEditingController dolarController = TextEditingController();
  final TextEditingController euroController = TextEditingController();
  double? dolar;
  double? euro;

  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: Text(
          '\$ Conversor de Moedas \$',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        'Caregando dados...',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar dados :(',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];

                  euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 150,
                          color: Colors.amber,
                        ),
                        BuildTextField(
                            label: "Real",
                            prefix: "R\$",
                            c: realController,
                            f: _realChanged),
                        const Divider(),
                        BuildTextField(
                            label: "Dólares",
                            prefix: "US\$",
                            c: dolarController,
                            f: _dolarChanged),
                        const Divider(),
                        BuildTextField(
                            label: "Euro",
                            prefix: "€",
                            c: euroController,
                            f: _euroChanged),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }

  void _realChanged(String text) {
    double real = 0;
    try {
      real = double.parse(text);
    } catch (e) {
      print("Invalid Format: " + e.toString());
    }

    dolarController.text = (real / dolar!).toStringAsFixed(2);
    euroController.text = (real / euro!).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = 0;
    try {
      dolar = double.parse(text);
    } catch (e) {
      print("Invalid Format: " + e.toString());
    }

    realController.text = (dolar * this.dolar!).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = 0;
    try {
      euro = double.parse(text);
    } catch (e) {
      print("Invalid Format: " + e.toString());
    }

    realController.text = (euro * this.euro!).toStringAsFixed(2);
    dolarController.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
  }
}
