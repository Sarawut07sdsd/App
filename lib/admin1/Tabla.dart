import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyAPI {
  static Future<List<dynamic>> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final response = await http.get(Uri.parse(
        'http://localhost/1Projest/leave_system/leave_system/apiApp/Tabla.php?Emp_id='+user.toString()));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class Tabla1 extends StatelessWidget {
  const Tabla1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        body: 
          Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<dynamic>>(
            future: MyAPI.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          'วันที่สแกน เข้าและ ออก งาน : ' +
                              data[index]['Ttb_date'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            Text(
                              'ชื่อผู้ใช้งาน ' + data[index]['Emp_name'],
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'เวลาสแกนเข้างาน :' + data[index]['Ttb_timein'],
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'รัตติจูด ละติจูด เข้างาน : ' +
                                  data[index]['Ttb_radiusin'],
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'เวลาสแกนออกงาน : ' +
                                  data[index]['Ttb_timeinout'],
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'รัตติจูด ละติจูด ออกงาน : ' +
                                  data[index]['Ttb_radiusout'],
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
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
