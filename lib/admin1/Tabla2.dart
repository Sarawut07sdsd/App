import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyAPI {
  static Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Tabla2 extends StatelessWidget {
    const Tabla2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<dynamic>>(
            future: MyAPI.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return DataTable(
                  columns: [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Company')),
                  ],
                  rows: data
                      .map((user) => DataRow(cells: [
                            DataCell(Text(user['id'].toString())),
                            DataCell(Text(user['name'])),
                            DataCell(Text(user['email'])),
                            DataCell(Text(user['company']['name'])),
                          ]))
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Failed to load data'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
