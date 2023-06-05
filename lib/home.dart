import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Data> listData = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(12),
                    color: Colors.greenAccent,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'v1: ${listData[index].v1}',
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'v2: ${listData[index].v2}',
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'datetime ${listData[index].dateTime}',
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(strokeAlign: 3),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Data>> getData() async {
    final response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbyz3JE5FLwwcj0o2OMymEx5RAWoaehj4gi5OrQsOdKvHDwjVpBwwtHHT4o_vswPYDGt6g/exec'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        listData.add(Data.fromJson(index));
      }
      return listData;
    } else {
      return listData;
    }
  }
}
