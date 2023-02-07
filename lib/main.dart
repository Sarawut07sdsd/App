import 'package:flutter/material.dart';
import 'package:flutter_application_1/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void sendPostRequest() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/albums/1');
  final response = await http.get(url);
  var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  var userId = jsonResponse['userId'];
  print(userId);
  /* print('Response status: ${response.statusCode}');
  print('Response body: ${jsonDecode(response.body)}'); */
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'ระบบลางาน และ ลงเวลาเข้าทำงาน';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
String _name = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'ยินดีต้อนรับสู่ระบบลางาน',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'รหัสประชาชน',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'รหัสผ่าน',
                ),
              
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text('เข้าสู่ระบบ'),
                  onPressed: () async {
                    final url = Uri.parse(
                        'https://jsonplaceholder.typicode.com/albums/1');
                    final response = await http.get(url);
                    var jsonResponse = convert.jsonDecode(response.body)
                        as Map<String, dynamic>;
                    var userId = jsonResponse['userId'];
                    if (userId == 1) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const MyApp2();
                      }));
                    }

                    
                  },
                )),
          ],
        ));
  }
}
