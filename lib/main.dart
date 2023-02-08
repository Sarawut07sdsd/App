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

///////////////////
  ///
  ///
  ///
  @override
  Future<void> _showAlertGoToWork() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('เข้าสู่ระบบไม่สำเร็จ ERROR !!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'เวลาที่คุณบันทึกเวลาเข้าจะตรงกับเวลาปัจจุบัน !!',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MyApp2();
                }));
              },
            ),
          ],
        );
      },
    );
  }

//////////////////////////////////////

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
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('เข้าสู่ระบบสำเร็จ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 180, 45),
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold)),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const MyApp2();
                              })),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('เข้าสู่ระบบไม่สำเร็จ ERROR !!',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 233, 1, 1),
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold)),
                          content: const Text('กรุณาตรวจสอบ ข้อมูลให้ถูกต้อง'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                )),
          ],
        ));
  }
}
