import 'package:conversor_moedas/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const url = "https://api.hgbrasil.com/finance?format=json-cors&key=79602364";

void main() async{
  print(await getData());
  runApp(const MyApp());
}

Future<Map> getData() async{
  http.Response response = await http.get(Uri.parse(url));
  print(json.decode(response.body)["results"]);
  return json.decode(response.body);
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Conversor(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(listTileTheme: ListTileThemeData(
        tileColor: Colors.white
      )),
    );
  }
}
